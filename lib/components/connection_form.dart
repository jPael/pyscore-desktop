import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/components/error_card.dart';
import 'package:pyscore/constants/types/custom_button_type.dart';
import 'package:pyscore/constants/errors/host_connect_errors.dart';
import 'package:pyscore/services/host_connection.dart';
import 'package:pyscore/utils/results.dart';

class ConnectionForm extends StatefulWidget {
  const ConnectionForm({super.key, this.actionButtons = const [], this.closeConfigure});

  final List<Widget> actionButtons;
  final VoidCallback? closeConfigure;

  @override
  ConnectionFormState createState() => ConnectionFormState();
}

class ConnectionFormState extends State<ConnectionForm> {
  bool isLoading = false;
  bool? connectionSuccess;
  String? errorMsg;

  TextEditingController ipController = TextEditingController();
  TextEditingController portController = TextEditingController();

  Future<void> handleHostConnect(HostConnection host) async {
    setState(() {
      connectionSuccess = null;
      isLoading = true;
    });

    final String ip = ipController.text;
    final String port = portController.text;

    context.read<HostConnection>().setHostAddress(ip, port);
    HostConnectResult result = await context.read<HostConnection>().connect();

    if (result.isSuccess) {
      setState(() {
        connectionSuccess = true;
        isLoading = false;
      });
    } else {
      setState(() {
        connectionSuccess = false;
        errorMsg = HostConnectErrors.error(result.error!);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    String? ip = HostConnection().ip;
    String? port = HostConnection().port;

    ipController.value = TextEditingValue(text: ip ?? "");
    portController.value = TextEditingValue(text: port ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HostConnection>(
      builder: (context, host, child) {
        if (connectionSuccess == true) {
          return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_rounded,
                      color: Colors.green,
                      size: 8 * 5,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        "You are now connected to the host",
                        softWrap: true,
                        style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8 * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(label: "Close", onTap: () => Navigator.pop(context)),
                  ],
                ),
              ]);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter the host's IP and port"),
            const SizedBox(
              height: 8 * 2,
            ),
            if (errorMsg != null) ...[
              SizedBox(child: ErrorCard(errorMsg: errorMsg!)),
              const SizedBox(
                height: 8 * 2,
              ),
            ],
            CustomInput(
              autoFocus: true,
              hintText: "",
              labelText: "IP",
              controller: ipController,
            ),
            const SizedBox(height: 8 * 2),
            CustomInput(
              hintText: "",
              labelText: "Port",
              controller: portController,
            ),
            const SizedBox(height: 8 * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...widget.actionButtons,
                CustomButton(
                  type: CustomButtonType.ghost,
                  label: "Back",
                  onTap: () {
                    widget.closeConfigure!();
                    // Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                CustomButton(
                    isLoading: isLoading,
                    label: "Connect",
                    onTap: () async => await handleHostConnect(host))
              ],
            )
          ],
        );
      },
    );
  }
}
