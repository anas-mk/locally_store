import 'package:flutter/material.dart';
import 'package:locally/presentation/home/widgets/categories.dart';
import 'package:locally/presentation/home/widgets/new_in.dart';
import 'package:locally/presentation/home/widgets/header.dart';
import 'package:locally/presentation/home/widgets/top_selling.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            SizedBox(height: 24,),
            Categories(),
            SizedBox(height: 10,),
            TopSelling(),
            SizedBox(height: 24,),
            NewIn(),
          ],
        ),
      ),
    );
  }
}
