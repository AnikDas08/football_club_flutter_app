import 'package:flutter/material.dart';
import 'package:football_club/features/home/data/repository_impl/home_repository_impl.dart';
import 'package:football_club/features/home/domain/entity/session_note_entity.dart';
import 'package:football_club/features/home/domain/repository/home_repository.dart';
import 'package:football_club/services/storage/storage_services.dart';
import 'package:get/get.dart';

class AllCoachFeedbackController extends GetxController {
  final HomeRepository homeRepository;

  AllCoachFeedbackController({HomeRepository? homeRepository})
      : homeRepository = homeRepository ?? HomeRepositoryImpl();

  final scrollController = ScrollController();
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var notes = <SessionNoteEntity>[].obs;

  int currentPage = 1;
  int totalPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchSessionNotes(isRefresh: true);
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      fetchMoreSessionNotes();
    }
  }

  Future<void> fetchSessionNotes({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      isLoading.value = true;
    }

    final playerId = LocalStorage.playerId.isNotEmpty
        ? LocalStorage.playerId
        : '534654';

    try {
      final result = await homeRepository.getSessionNotes(
        playerId: playerId,
        page: currentPage,
        limit: 10,
      );

      if (isRefresh) {
        notes.assignAll(result.notes);
      } else {
        notes.addAll(result.notes);
      }
      totalPage = result.totalPage;
    } catch (_) {
      // Handle error gracefully
    } finally {
      if (isRefresh) {
        isLoading.value = false;
      }
    }
  }

  Future<void> fetchMoreSessionNotes() async {
    if (isLoadingMore.value || currentPage >= totalPage) return;

    try {
      isLoadingMore.value = true;
      currentPage++;

      final playerId = LocalStorage.playerId.isNotEmpty
          ? LocalStorage.playerId
          : '534654';

      final result = await homeRepository.getSessionNotes(
        playerId: playerId,
        page: currentPage,
        limit: 10,
      );

      notes.addAll(result.notes);
      totalPage = result.totalPage;
    } catch (_) {
      currentPage--;
    } finally {
      isLoadingMore.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
