// import 'package:clean_architecture/core/components/primary_button.dart';
// import 'package:clean_architecture/core/helpers/colours.dart';
// import 'package:clean_architecture/core/helpers/dimens.dart';
// import 'package:clean_architecture/core/helpers/strings.dart';
// import 'package:clean_architecture/core/helpers/textstyles.dart';
// import 'package:clean_architecture/core/utils/enums.dart';
// import 'package:flutter/material.dart';
//
// class NoInternet extends StatefulWidget {
//   final VoidCallback onTap;
//
//   const NoInternet({super.key, required this.onTap});
//
//   @override
//   State<NoInternet> createState() => _NoInternetState();
// }
//
// class _NoInternetState extends State<NoInternet> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Icon(Icons.cloud_off, size: Dimens.dm100, color: Colours.red),
//         const SizedBox(height: Dimens.dm20),
//         Text(Strings.notInternetMessage,
//             style: TextStyles.textStyle4, textAlign: TextAlign.center),
//         const SizedBox(height: Dimens.dm20),
//         PrimaryButton(
//             onTap: widget.onTap,
//             status: ApiStatus.initial,
//             text: Strings.tryAgain)
//       ],
//     );
//   }
// }
