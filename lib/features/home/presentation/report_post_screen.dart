import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/di/injector.dart';
import '../../../core/shared_widgets/app_back_button.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../domain/usecases/submit_post_report_usecase.dart';
import 'local_widgets/post_card.dart';
import 'providers/feed_provider.dart';

class ReportPostScreen extends ConsumerStatefulWidget {
  const ReportPostScreen({super.key, required this.postId});

  final String postId;

  @override
  ConsumerState<ReportPostScreen> createState() => _ReportPostScreenState();
}

class _ReportPostScreenState extends ConsumerState<ReportPostScreen> {
  final TextEditingController _reasonController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    final result = await getIt<SubmitPostReportUseCase>().call(
      postId: widget.postId,
      reason: _reasonController.text,
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    result.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message))),
      (_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report submitted. Thanks for letting us know.')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(feedControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 8),
              child: Align(alignment: Alignment.centerLeft, child: AppBackButton()),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    feedAsync.when(
                      data: (posts) {
                        final post = posts.firstWhere(
                          (post) => post.id == widget.postId,
                          orElse: () => posts.first,
                        );
                        return PostCard(
                          post: post,
                          onLikeTap: () => ref.read(feedControllerProvider.notifier).toggleLike(post.id),
                        );
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(color: AppColors.primary),
                      ),
                      error: (error, stackTrace) => const SizedBox.shrink(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: TextField(
                        controller: _reasonController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Write a report about this post...',
                          filled: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: AppColors.textSecondary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: AppColors.textSecondary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: AppButton(label: 'Submit Report', isLoading: _isSubmitting, onPressed: _submit),
            ),
          ],
        ),
      ),
    );
  }
}
