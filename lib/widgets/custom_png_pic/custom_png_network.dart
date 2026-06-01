// import 'package:flutter/cupertino.dart';
//
// class CustomPngNetwork extends StatelessWidget {
//   final double width;
//   final double height;
//   final String image;
//   final VoidCallback? onTap;
//
//   const CustomPngNetwork({
//     required this.width,
//     required this.height,
//     required this.image,
//     this.onTap,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: SizedBox(
//         width: width,
//         height: height,
//         // ignore: deprecated_member_use
//         child: Image.network(image, fit: BoxFit.cover),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';

class CustomPngNetwork extends StatelessWidget {
  final double width;
  final double height;
  final String? image;
  final VoidCallback? onTap;

  const CustomPngNetwork({
    required this.width,
    required this.height,
    required this.image,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isValidImage = image != null && image!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: isValidImage
            ? Image.network(
                image!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder();
                },
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      alignment: Alignment.center,
      color: CupertinoColors.systemGrey5,
      child: const Icon(
        CupertinoIcons.photo,
        size: 30,
        color: CupertinoColors.systemGrey,
      ),
    );
  }
}
