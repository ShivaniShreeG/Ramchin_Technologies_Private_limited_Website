//
// class DesktopHomePage extends StatelessWidget {
//   final int selectedIndex;
//   final void Function(int) onTabSelected;
//
//   const DesktopHomePage({
//     super.key,
//     required this.selectedIndex,
//     required this.onTabSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return IndexedStack(
//       index: selectedIndex,
//       children: [
//         HomePageStack(
//           selectedIndex: selectedIndex,
//           onTabSelected: onTabSelected,
//         ),
//         ProductPageStack(),
//         TeamPageStack(),
//         ProjectPageStack(),
//         ServicePageStack(onTabSelected: onTabSelected),
//         InternshipPageStack(),
//         GalleryPageStack(),
//         ContactUsPageStack(onTabSelected: onTabSelected),
//         AboutPageStack(),
//         AdminPageStack(onTabSelected: onTabSelected),
//         AddDataPageStack(),
//       ],
//     );
//   }
// }
