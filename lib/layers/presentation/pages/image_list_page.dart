import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_starter_template/injection/injection.dart';
import 'package:flutter_starter_template/layers/domain/stores/i_image_list_store.dart';

class ImageListPage extends StatefulWidget {
  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  final IImageListStore store = getIt();

  @override
  void initState() {
    super.initState();
    store.loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
      ),
      body: Observer(
        builder: (context) {
          return store.status.when(
            loading: () => const CircularProgressIndicator(),
            error: () {
              return const Center(
                child: Text('error'),
              );
            },
            success: () {
              // return ListView.separated(
              //   itemBuilder: null,
              //   separatorBuilder: null,
              //   itemCount: null,
              // );
              return Text(store.images.toString());
            },
          );
        },
      ),
    );
  }
}
