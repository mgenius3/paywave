import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:paywave/data/models/user_account.dart';
import 'package:paywave/presentation/bloc/logic/finances.dart';
import 'package:paywave/presentation/screens/main/main_styles.dart';
import 'package:paywave/presentation/theme/app_colors.dart';

import 'floating_menu_dialog.dart';
import 'preview_receiver_widget.dart';

enum SendFundsResult { done }

class SendFundsDialog extends StatefulWidget {
  const SendFundsDialog({super.key});

  @override
  State<SendFundsDialog> createState() => _SendFundsDialogState();
}

class _SendFundsDialogState extends State<SendFundsDialog> {
  final _formKey = GlobalKey<FormState>();
  String userID = "";
  String amount = "";
  bool loading = false;
  UserAccount? receiver;

  Future _openDialog(Widget dialog, {dismissible = true}) {
    return showDialog<SendFundsResult>(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext context) {
          return dialog;
        }).then(_handleResult);
  }

  Future? _handleResult(SendFundsResult? result) {
    switch (result) {
      default:
        return null;
    }
  }

  void _sendFunds() {
    setState(() {
      print({"user": userID, "amount": amount});
      loading = true;
      Future.delayed(Duration(seconds: 3)).then((_) {
        setState(() {
          loading = false;
          receiver = userAccount;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      insetPadding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        finishWithResult(context, null);
                      },
                      icon: const Icon(IconsaxOutline.close_square))),
              Text("Send Funds", style: MainStyles.headlineMedium(context)),
              Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "User ID/Account Number",
                    ),
                    onFieldSubmitted: (value) {
                      setState(() {
                        userID = value;
                      });
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 64),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Amount",
                        suffixIcon: Icon(IconsaxOutline.coin_1)),
                    onFieldSubmitted: (value) {
                      setState(() {
                        amount = value;
                      });
                    },
                  )),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: MainStyles.elevatedButton(context),
                      onPressed: _sendFunds,
                      child: const Text("Send"))),
              loading
                  ? const Center(
                      heightFactor: 2.5,
                      child: SizedBox.square(
                          dimension: 122,
                          child: CircularProgressIndicator(
                            strokeWidth: 9.0,
                          )),
                    )
                  : receiver != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 56),
                          child: PreviewReceiverWidget(receiver!))
                      : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
