// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'bloc.dart';
import 'user_model.dart';

class LazyLoadingHome extends StatefulWidget {
  const LazyLoadingHome({Key? key}) : super(key: key);

  @override
  _LazyLoadingHomeState createState() => _LazyLoadingHomeState();
}

class _LazyLoadingHomeState extends State<LazyLoadingHome> {
  final _bloc = Bloc();

  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _bloc.getMoreUsers();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Loading'),
      ),
      body: StreamBuilder<List<User>>(
        stream: _bloc.outListOfUsers,
        builder: (context, snapshot) {
          List<User>? listOfUsers = snapshot.data;
          int itemCount = listOfUsers?.length ?? 0;
          var error = snapshot.error;
          bool hasData = snapshot.hasData;
          if (error != null) {
            return const Center(child: Text('Error!'));
          }
          if (hasData) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                User user = listOfUsers![index];
                if (index == _bloc.listOfUsers.length - 1) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text('Loading more Users...'),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        user.picture!.thumbnail!,
                      ),
                    ),
                    title: Text(user.name!.first!),
                    subtitle: Text(user.name!.last!),
                  );
                }
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
