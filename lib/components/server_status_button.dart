import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/services/server/create_server.dart';

class ServerStatusButton extends StatelessWidget {
  const ServerStatusButton({super.key, required this.server});

  final CreateServer server;

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
            title: const Text('Invite your students to join'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Ask your students to connect to the following: "),
                const SizedBox(height: 24),
                CustomInput(
                  hintText: "",
                  labelText: "IP Address",
                  value: server.ip ?? "IP address unavailable",
                  readOnly: true,
                ),
                const SizedBox(height: 12),
                CustomInput(
                  hintText: "",
                  labelText: "Port",
                  value: server.port != null
                      ? server.port.toString()
                      : "Port unavailable",
                  readOnly: true,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Server Status: "),
        const Icon(Icons.circle, color: Colors.greenAccent),
        const Text(
          "Online",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 12,
        ),
        CustomButton(
            label: "Show IP address",
            onTap: () async => _showMyDialog(context)),
      ],
    );
  }
}
