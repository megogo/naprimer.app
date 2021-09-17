import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naprimer_app_v2/app/pages/settings/menu/menu_item_widget.dart';

import '../field_type.dart';

class Menu extends StatelessWidget {
  final String header;
  final List<MenuItemModel> menuItems;

  const Menu({Key? key, required this.header, required this.menuItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            header,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white.withAlpha(125),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          child: Column(
              children: menuItems
                  .map((menuItemModel) => MenuItemWidget(
                        label: menuItemModel.title,
                        onTap: () => menuItemModel.onTap(),
                      ))
                  .toList()),
        )
      ],
    );
  }
}

class MenuItemModel {
  final String title;
  final dynamic value;
  final Function onTap;
  final FieldType fieldType;

  MenuItemModel(
      {required this.title,
      required this.value,
      required this.onTap,
      required this.fieldType});
}
