// import 'package:afreed_app/constants/app_colors.dart';
// import 'package:afreed_app/helpers/responsive_utils.dart';
// import 'package:flutter/material.dart';

// import '../../constants/text_font_style.dart';

// void internetConnectionPopup(BuildContext context, VoidCallback onRetry) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           height: SizeConfig.height(25),
//           padding: const EdgeInsets.all(12),
//           width: SizeConfig.height(18),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(
//                 Icons.wifi_off,
//                 color: Colors.red,
//                 size: 40,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'No Internet Connection found. \nCheck your connection & try again.',
//                 style: TextFontStyle.textStyle16Roboto
//                     .copyWith(color: AppColors.c000000),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   onRetry();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.allPrimaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Retry',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
