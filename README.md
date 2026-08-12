# Chatix

A real-time chat application built with Flutter — Phase 1 (messaging, presence, notifications) complete. Phase 2 (audio/video calling with WebRTC) is next.

---

## Features

### Authentication
- Email/password signup and login via **Supabase Auth**
- Phone number OTP verification via **Firebase Phone Auth**, bridged into a real Supabase session through a dedicated Edge Function (since Supabase's default SMS provider, Twilio, no longer supports Pakistani numbers)

### Messaging
- Real-time text, image, and voice messages
- **Optimistic sends** — messages appear instantly on send, backed by the local file, and seamlessly swap to the confirmed version once synced (no flicker, no gap)
- **Voice notes** with a real waveform — computed once at record time and embedded with the message, so no device (sender or receiver) ever needs to re-download and re-decode audio just to draw its shape
- **Images** with a BlurHash blur-up placeholder — a blurred preview renders instantly while the real photo loads, then cross-fades in
- Read receipts and per-conversation unread badges
- Date separators (Today / Yesterday / full date)

### Presence & Typing
- Online/offline status with a "last seen" label, kept accurate via a client heartbeat and a 2-minute staleness check (never trusts a single boolean alone)
- Live typing indicators, shown both in the chat list row and inside the open chat

### Push Notifications
- Real message content shown in the notification (not a placeholder)
- Multiple unseen messages from the same conversation stack into one expandable, updating notification — not separate banners
- A single incoming image shows an actual photo thumbnail
- Tapping a notification opens the exact conversation
- Notifications clear automatically once the conversation is read

### Performance & Offline Feel
- **Local caching with Hive** — chat list, messages, and pending notification data are cached locally, either on first fetch or the moment new data arrives, so reopening the app feels instant instead of reloading from scratch
- Prefetching for the most recently active conversations at login, so chats open with zero loading in the common case
- Loading skeletons are used only where genuinely unavoidable (a true first-ever load with nothing cached yet) — not on every visit

---

## Architecture

**Clean Architecture** throughout, with a consistent `presentation / domain / data` split per feature:

```
features/<feature_name>/
  data/
    datasources/
      local/       Hive-backed caching
      remote/      Supabase queries, RPC calls, Realtime subscriptions
    models/        fromJson/toJson mapping
    mappers/       model to entity conversion
    repositories/  combines local (cache) + remote (live) into one stream
  domain/
    entities/
    repositories/  abstract interfaces
    usecases/
    params/        usecase input parameter objects
  presentation/
    providers/     Riverpod (code-generated, @riverpod)
    screens/
```

- **State management:** Riverpod, with code generation (`@riverpod`) — no manual `StateNotifier`
- **Dependency injection:** `injectable` + `get_it`, auto-registered via `build_runner`
- **Routing:** `go_router`

---

## Backend

| Concern | Technology | Why |
|---|---|---|
| Database | **Supabase (Postgres)** | Relational, real joins, cheaper at scale than a per-document model for a chat app's read/write volume |
| Real-time delivery | **Supabase Realtime** | Messages, presence, and typing all ride Postgres Changes / Broadcast channels — no separate self-hosted socket server |
| File storage | **Supabase Storage** | Chat images and voice notes |
| Auth (email/password) | **Supabase Auth** | Native to the same backend |
| Auth (phone OTP) | **Firebase Phone Auth** | Only used for OTP delivery/verification — bridged into a real Supabase session server-side |
| Push notifications | **Firebase Cloud Messaging (FCM)** | The one thing Supabase doesn't do |

### Database schema

Six tables, all with **Row Level Security** enabled:

- `profiles` — user identity, presence fields (`is_online`, `last_seen_at`), auto-created via a trigger on every new `auth.users` row
- `conversations` — direct (1:1) chats
- `conversation_participants` — join table, also tracks `unread_count`
- `messages` — text/image/voice, with `status` (sent/delivered/seen) and embedded `waveform_samples` for voice notes
- `device_tokens` — FCM tokens per user/platform
- `calls` — schema in place for Phase 2

### Postgres RPC functions

Identity is always derived server-side from `auth.uid()` — never trusted from a client-supplied parameter:

- `mark_conversation_read(conversation_id)` — resets unread count, flips message status to seen
- `update_last_seen()` — presence heartbeat, called every ~30s while foregrounded
- `set_offline()` — called on app pause/logout
- `get_or_create_direct_conversation(other_user_id)` — atomically finds or creates a 1:1 conversation, preventing duplicate conversations under a race condition (e.g. two users tapping "message" on each other simultaneously)

### Edge Functions

- **`bridge-phone-auth`** — verifies a Firebase-issued phone auth token server-side, then finds or creates the matching Supabase user and returns a real Supabase session
- **`send-push-notification`** — triggered by a **Database Webhook** on every `messages` INSERT; looks up the recipient's device token and the sender's profile, then calls the FCM v1 API directly

---

## Known Trade-offs / Future Improvements

- Local caching is written-through on fetch/update — a more production-grade setup would add background sync via WorkManager or a background service to detect connectivity changes and sync proactively. Out of scope for this phase; the focus here was real-time messaging and notifications specifically.
- Chat header data (name/avatar/status) prefetching and the chat list's loading-skeleton conditions have a documented, deferred plan for further tightening — noted for a future pass once the current implementation has been used and confirmed stable.
- `chat-media` storage bucket policies are currently "any authenticated user can read/write," relying on unguessable UUID paths — a reasonable Phase 1 trade-off, flagged to revisit with path-scoped policies before any public launch.

---

## Tech Stack

- **Flutter** + **Riverpod** (codegen) + **injectable/get_it**
- **Supabase** (Postgres, Realtime, Storage, Auth, Edge Functions)
- **Firebase** (Phone Auth, Cloud Messaging)
- **Hive** — local caching
- **awesome_notifications** — rich, grouped push notifications
- **audio_waveforms** — voice note recording/playback
- **flutter_blurhash** / **blurhash_dart** — image blur-up placeholders
- **cached_network_image** — image loading/caching

---

## Roadmap

- **Phase 1 — Complete:** Auth, real-time messaging (text/image/voice), presence, typing indicators, push notifications, local caching
- **Phase 2 — Next:** Audio and video calling via **WebRTC**, signaled over Supabase Realtime, with native call handling (CallKit / ConnectionService) for incoming calls even when the app is backgrounded or closed
