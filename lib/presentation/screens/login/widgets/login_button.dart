// import 'package:clean_architecture/core/components/flush_bar/toast.dart';
// import 'package:clean_architecture/core/components/primary_button.dart';
// import 'package:clean_architecture/core/helpers/strings.dart';
// import 'package:clean_architecture/core/utils/enums.dart';
// import 'package:clean_architecture/presentation/screens/login/bloc/login_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class LoginButton extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//
//   const LoginButton({super.key, required this.formKey});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginBloc, LoginState>(
//       listenWhen: (current, previous) => current.status != previous.status,
//       listener: (context, state) {
//         if (state.status == ApiStatus.error) {
//           Toast.showToastMessage(
//               context: context, message: state.message, status: state.status);
//         }
//         if (state.status == ApiStatus.completed) {
//           // Navigator.of(context)
//           //     .pushNamedAndRemoveUntil(Routes.homeScreen, (route) => false);
//         }
//       },
//       child: BlocBuilder<LoginBloc, LoginState>(
//         buildWhen: (current, previous) => current.status != previous.status,
//         builder: (context, state) {
//           return PrimaryButton(
//               text: Strings.loginBtn,
//               status: state.status,
//               onTap: () {
//                 if (formKey.currentState!.validate()) {
//                   context.read<LoginBloc>().add(UserLogin());
//                 }
//               });
//         },
//       ),
//     );
//   }
// }
