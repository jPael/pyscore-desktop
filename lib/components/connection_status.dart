import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/connection_dialog_card.dart';
import 'package:pyscore/services/host_connection.dart';

class ConnectionStatus extends StatefulWidget {
  const ConnectionStatus({super.key});

  @override
  ConnectionStatusState createState() => ConnectionStatusState();
}

class ConnectionStatusState extends State<ConnectionStatus> {
  Future<void> showConnectionDialog() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (context, setState) => const Dialog(
                  child: ConnectionDialogCard(),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HostConnection>(
      builder: (context, host, child) {
        final bool isConnected = host.isConnected;

        return GestureDetector(
          onTap: () => showConnectionDialog(),
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8 * 2),
              child: isConnected ? connected(context) : notConnected(context),
            ),
          ),
        );
      },
    );
  }

  Widget connected(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Status",
          style: TextStyle(fontSize: 8 * 2, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 8,
        ),
        Icon(
          Icons.circle,
          color: Colors.greenAccent,
        ),
      ],
    );
  }

  Widget notConnected(BuildContext context) {
    return const Tooltip(
      message: "You are not connected",
      child: Row(
        children: [
          Text(
            "Status",
            style: TextStyle(fontSize: 8 * 2, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 8,
          ),
          Icon(
            Icons.info_rounded,
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
