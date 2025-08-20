import 'package:flutter/material.dart';
import 'package:locally/common/widgets/appbar/app_bar.dart';
import 'package:locally/presentation/settings/widgets/my_account_tile.dart';
import 'package:locally/presentation/settings/widgets/my_orders_tile.dart';
import 'package:locally/presentation/settings/widgets/sign_out.dart';
import '../widgets/my_favorties_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BasicAppbar(
        title: Text(
          'Profile',
        ),
        hideBack: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            MyAccountTile(),
            SizedBox(height: 15,),
            MyFavortiesTile(),
            SizedBox(height: 15,),
            MyOrdersTile(),
            Spacer(),
            SignOut(),
          ],
        ),
      ),
    );
  }
}