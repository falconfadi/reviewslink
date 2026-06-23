import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPngNetwork extends StatelessWidget {

  final double width;
  final double height;
  final String? image;

  const CustomPngNetwork({
    required this.width,
    required this.height,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isValidImage = image != null && image!.isNotEmpty;

    return SizedBox(
      width: width,
      height: height,
      child: isValidImage ? Image.network(
        image!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
          },
      ) : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      alignment: Alignment.center,
      color: CupertinoColors.systemGrey5,
      child: Icon(
        CupertinoIcons.photo,
        size: 35.sp,
        color: CupertinoColors.systemGrey,
      ),
    );
  }
}
