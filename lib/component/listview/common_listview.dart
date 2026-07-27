import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../other_widgets/common_loader.dart';

class CommonListView extends StatefulWidget {
  const CommonListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.height,
    this.width,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.physics = const BouncingScrollPhysics(),
    this.shrinkWrap = true,
    this.primary,
    this.separatorBuilder,
    this.spacing,
    this.controller,
    this.reverse = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.clipBehavior = Clip.hardEdge,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.isLoadingMore = false,
    this.onLoadMore,
    this.loadingWidget,
    this.scrollThreshold = 200,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.restorationId,
    this.findChildIndexCallback,
  });

  final Axis scrollDirection;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double? height;
  final double? width;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool? primary;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final double? spacing;
  final ScrollController? controller;
  final bool reverse;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final Clip clipBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool isLoadingMore;
  final VoidCallback? onLoadMore;
  final Widget? loadingWidget;
  final double scrollThreshold;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final String? restorationId;
  final int? Function(Key)? findChildIndexCallback;

  @override
  State<CommonListView> createState() => _CommonListViewState();
}

class _CommonListViewState extends State<CommonListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    if (widget.onLoadMore != null) {
      _scrollController.addListener(_scrollListener);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - widget.scrollThreshold) {
      if (!widget.isLoadingMore) {
        widget.onLoadMore?.call();
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int effectiveItemCount =
        widget.isLoadingMore ? widget.itemCount + 1 : widget.itemCount;

    Widget buildItem(BuildContext context, int index) {
      if (widget.isLoadingMore && index == widget.itemCount) {
        return widget.loadingWidget ??
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: const CommonLoader(size: 30),
            );
      }
      return widget.itemBuilder(context, index);
    }

    Widget listView;

    if (widget.separatorBuilder != null || widget.spacing != null) {
      listView = ListView.separated(
        controller: _scrollController,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        primary: widget.primary,
        padding: EdgeInsets.zero,
        itemCount: effectiveItemCount,
        itemBuilder: buildItem,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        clipBehavior: widget.clipBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        cacheExtent: widget.cacheExtent,
        dragStartBehavior: widget.dragStartBehavior,
        restorationId: widget.restorationId,
        findChildIndexCallback: widget.findChildIndexCallback,
        separatorBuilder: (context, index) {
          if (widget.isLoadingMore && index == widget.itemCount - 1) {
            return const SizedBox.shrink();
          }
          return widget.separatorBuilder != null
              ? widget.separatorBuilder!(context, index)
              : SizedBox(
                  width: widget.scrollDirection == Axis.horizontal
                      ? widget.spacing?.w
                      : 0,
                  height: widget.scrollDirection == Axis.vertical
                      ? widget.spacing?.h
                      : 0,
                );
        },
      );
    } else {
      listView = ListView.builder(
        controller: _scrollController,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        primary: widget.primary,
        padding: EdgeInsets.zero,
        itemCount: effectiveItemCount,
        itemBuilder: buildItem,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        clipBehavior: widget.clipBehavior,
        cacheExtent: widget.cacheExtent,
        dragStartBehavior: widget.dragStartBehavior,
        restorationId: widget.restorationId,
        findChildIndexCallback: widget.findChildIndexCallback,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
      );
    }

    if (widget.scrollDirection == Axis.horizontal && widget.height != null) {
      listView = SizedBox(
        height: widget.height!.h,
        child: listView,
      );
    } else if (widget.scrollDirection == Axis.vertical && widget.width != null) {
      listView = SizedBox(
        width: widget.width!.w,
        child: listView,
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: widget.left.w,
        right: widget.right.w,
        top: widget.top.h,
        bottom: widget.bottom.h,
      ),
      child: listView,
    );
  }
}
