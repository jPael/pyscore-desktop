import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/models/my_classrooms.dart';

class RefreshClassButton extends StatefulWidget {
  const RefreshClassButton({super.key});

  @override
  _RefreshClassButtonState createState() => _RefreshClassButtonState();
}

class _RefreshClassButtonState extends State<RefreshClassButton> {
  bool isLoading = false;

  Future<void> handleLoading() async {
    setState(() {
      isLoading = true;
    });

    context.read<MyClassrooms>().refetchData();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: "Refresh",
      onTap: handleLoading,
      isLoading: isLoading,
    );
  }
}
