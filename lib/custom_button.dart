import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.isSelected = false,
    this.icon = Icons.abc,
    this.title = 'Title',
    this.onTap,
    this.onlyIcon = false,
  }) : super(key: key);
  final bool isSelected;
  final bool onlyIcon;
  final IconData icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: onlyIcon
              ? Container(
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        title,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
