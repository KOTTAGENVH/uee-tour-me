import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onChanged;

  const CustomToggleButton({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isToggled = !isToggled;
        });
        widget.onChanged(isToggled);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isToggled ? Colors.pink : Colors.grey,
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: 200.0, // Width of the switch
        height: 40.0, // Height of the switch
        child: Row(
          mainAxisAlignment: isToggled
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 35.0,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                'Destination',
                style: TextStyle(
                  color: isToggled ? Colors.grey : Colors.white,
                ),
              ),
            ),
            Container(
              width: 35.0,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                'Souvenir',
                style: TextStyle(
                  color: isToggled ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
