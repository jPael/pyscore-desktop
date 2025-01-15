import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.errorMsg});
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Error: ",
            style:
                TextStyle(color: Colors.red[800], fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              errorMsg,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
