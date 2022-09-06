import 'package:admin/constants.dart';
import 'package:admin/screens/testScreen/providers/StorageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main/components/side_menu.dart';

class StorageList extends StatelessWidget {
  const StorageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("Images"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<StorageProvider>(
          create: (context) => StorageProvider(),
          builder: (context, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(defaultPadding),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.80,
                child: Consumer<StorageProvider>(
                  builder: (context, value, child) {
                    if (value.imgs.isEmpty)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            child: Image.network(
                              value.imgs[index],
                              height: MediaQuery.of(context).size.height * 0.20,
                              width: MediaQuery.of(context).size.width * 0.80,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: value.imgs.length,
                      );
                  },
                ),
              ),
            );
          }),
    );
  }
}
