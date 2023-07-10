import 'package:flutter/material.dart';
import 'package:listviewflutter_testing/repositories/question_model.dart';

class ListData extends StatefulWidget {
  final List<QuestionModel> dataList;

  const ListData({Key? key, required this.dataList}) : super(key: key);

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  int loadedItemCount = 5; // Number of items to load each time
  int currentIndex = 0; // Index of the first visible item
  int visibleItems = 5; //no of visible items at a time
  bool isLoading = false;
  final _scrollController = ScrollController();
  bool showRefreshIndicator = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleData = widget.dataList.sublist(currentIndex, visibleItems);
    // debugPrint('currrent=$currentIndex and loaded $visibleItems');

    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final item = visibleData[index];

              return ListTile(
                title: Text(item.title.toString()),
                subtitle: Text(item.body),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green,
                  child: Text(
                    item.id.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
            itemCount: visibleData.length,
          ),
          if (showRefreshIndicator)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white70,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _refreshItems() async {
    setState(() {
      showRefreshIndicator = true;
    });
    await Future.delayed(const Duration(seconds: 3)); // Simulate refresh delay
    _loadMoreItems();

    setState(() {
      showRefreshIndicator = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      _refreshItems();
    }
  }

  void _loadMoreItems() {
    if (isLoading) return; // Avoid multiple simultaneous requests

    setState(() {
      isLoading = true;
    });

    // Simulate loading delay
    Future.delayed(const Duration(seconds: 0), () {
      if (loadedItemCount < widget.dataList.length) {
        setState(() {
          visibleItems += loadedItemCount;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }
}
