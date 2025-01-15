import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/connection_form.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/constants/custom_button_type.dart';
import 'package:pyscore/services/host_connection.dart';

class ConnectionDialogCard extends StatefulWidget {
  const ConnectionDialogCard({
    super.key,
  });

  @override
  ConnectionDialogCardState createState() => ConnectionDialogCardState();
}

class ConnectionDialogCardState extends State<ConnectionDialogCard> {
  bool openConfigure = false;

  void closeConfigure() => setState(() {
        openConfigure = false;
      });

  void handleOpenConfigure() => setState(() {
        openConfigure = true;
      });

  @override
  Widget build(BuildContext context) {
    return Consumer<HostConnection>(
      builder: (context, host, child) {
        bool isConnected = host.isConnected;

        return Container(
          padding: const EdgeInsets.all(16.0),
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    isConnected
                        ? "Connect to"
                        : openConfigure
                            ? "Connect to"
                            : "Connection Info",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(height: 24),
              !isConnected
                  ? const ConnectionForm()
                  : openConfigure
                      ? ConnectionForm(closeConfigure: closeConfigure)
                      : connectionDisplay(
                          context: context,
                          openConfigure: openConfigure,
                          handleOpenConfigure: handleOpenConfigure,
                          host: host),
            ],
          ),
        );
      },
    );
  }

  Widget connectionDisplay(
      {required BuildContext context,
      required bool openConfigure,
      required Function handleOpenConfigure,
      required HostConnection host}) {
    final String ip = HostConnection().ip!;
    final String port = HostConnection().port!;

    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: Colors.greenAccent),
              Text(
                " Connected",
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            height: 8 * 2,
          ),
          CustomInput(
            hintText: "",
            labelText: "IP",
            readOnly: true,
            value: ip,
          ),
          const SizedBox(
            height: 8 * 2,
          ),
          CustomInput(
            hintText: "",
            labelText: "Port",
            readOnly: true,
            value: port,
          ),
          const SizedBox(
            height: 8 * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                  type: CustomButtonType.ghost,
                  label: "Close",
                  onTap: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(
                width: 8,
              ),
              CustomButton(
                label: "Disconnect",
                onTap: () => host.disconnect(context),
                type: CustomButtonType.ghost,
              ),
              const SizedBox(
                width: 8,
              ),
              CustomButton(
                label: "Configure",
                onTap: () => handleOpenConfigure(),
              )
            ],
          )
        ],
      ),
    );
  }
}
