import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/cubit/task_cubit.dart';

class FilterSection extends StatelessWidget {
  final String selectedFilter;

  const FilterSection({super.key, required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            buildFilterButton(context, 'All'),
            SizedBox(width: 10),
            buildFilterButton(context, 'Pending'),
            SizedBox(width: 10),
            buildFilterButton(context, 'Completed'),
          ],
        ),
      ],
    );
  }

  Widget buildFilterButton(BuildContext context, String text) {
    bool isSelected = selectedFilter == text;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<TaskCubit>().changeFilter(text);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF536DFE) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Color(0xFF536DFE) : Colors.grey.shade400,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}