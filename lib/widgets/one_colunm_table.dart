import 'package:flutter/material.dart';

class OneColumnTable extends StatelessWidget {
  final List<String> items;

  const OneColumnTable({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
       width: 300, 
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
        border: Border.all(
          color: Colors.grey, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: DataTable(
        dataRowMinHeight: 40, // Adjust the row height as needed
        columnSpacing: 5.0,
        columns:const  <DataColumn>[
          DataColumn(
            label: Text('Selection'
            , style: TextStyle(color: Colors.white , fontSize: 15),
            ),
          ),
        ],
        rows: items.map((item) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(item)),
            ],
            color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              // Set the row color to grey when it's selected or hovered.
              if (states.contains(MaterialState.selected) || states.contains(MaterialState.hovered)) {
                return const Color.fromARGB(255, 70, 69, 69);
              }
              // Default row color when not selected or hovered.
              return Colors.grey;
            }),
          );
        }).toList(),
        
      ),
    );
  }
}
