import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:chest_flutter/chest_flutter.dart';
import 'package:flutter/material.dart';

import 'core/core.dart';
import 'i18n.dart';
import 'theme.dart';
import 'todo_item.dart';

class CompletedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReferencesBuilder(
      references: [list.inTheCart, list.notAvailable],
      builder: (context) {
        return Row(
          children: [
            Expanded(
              child: CompletedBucket(
                primaryText: list.inTheCart.length.toString(),
                secondaryText: context.t.mainInTheCart,
                color: context.color.inTheCartTint,
                onTap: () {
                  context.navigator.push(MaterialPageRoute(
                    builder: (_) => InTheCartPage(),
                  ));
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CompletedBucket(
                primaryText: list.notAvailable.length.toString(),
                secondaryText: context.t.mainNotAvailable,
                color: context.color.notAvailableTint,
                onTap: () {
                  context.navigator.push(MaterialPageRoute(
                    builder: (_) => NotAvailablePage(),
                  ));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class CompletedBucket extends StatelessWidget {
  const CompletedBucket({
    required this.primaryText,
    required this.secondaryText,
    required this.color,
    required this.onTap,
  });

  final String primaryText;
  final String secondaryText;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                primaryText,
                style: context.accentStyle.copyWith(fontSize: 20),
              ),
              SizedBox(height: 4),
              Text(secondaryText, style: context.standardStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class InTheCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.color.inTheCartTint.alphaBlendOn(context.color.background),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: context.color.onBackground),
        elevation: 0,
        title: Text(context.t.inTheCartTitle, style: context.appBarStyle),
        actions: [
          TextButton(
            child: Text(context.t.inTheCartClearAll),
            onPressed: () => list.inTheCart.value = [],
          ),
        ],
      ),
      body: ReferenceBuilder(
        reference: list.inTheCart,
        builder: (context) {
          return ListView.builder(
            itemCount: list.inTheCart.length,
            itemBuilder: (context, index) => TodoItem(
              item: list.inTheCart[index].value,
            ),
          );
        },
      ),
    );
  }
}

class NotAvailablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.color.notAvailableTint.alphaBlendOn(context.color.background),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: context.color.onBackground),
        elevation: 0,
        title: Text(context.t.notAvailableTitle, style: context.appBarStyle),
        actions: [
          TextButton(
            child: Text(context.t.notAvailableClearAll),
            onPressed: () => list.notAvailable.value = [],
          ),
        ],
      ),
      body: ReferenceBuilder(
        reference: list.notAvailable,
        builder: (context) {
          return ListView.builder(
            itemCount: list.notAvailable.length,
            itemBuilder: (context, index) => TodoItem(
              item: list.notAvailable[index].value,
            ),
          );
        },
      ),
    );
  }
}
