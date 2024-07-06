import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.imageUrl, required this.onUpload});

  final String? imageUrl;
  final void Function(String) onUpload;

  void updatePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageExtension = image.path.split('.').last.toLowerCase();
    final imageBytes = await image.readAsBytes();
    final userId = supabase.auth.currentUser!.id;
    final imagePath = '/$userId/profile';
    await supabase.storage.from('profiles').uploadBinary(
          imagePath,
          imageBytes,
          fileOptions: FileOptions(
            upsert: true,
            contentType: 'image/$imageExtension',
          ),
        );
    String imageUrl = supabase.storage.from('profiles').getPublicUrl(imagePath);
    imageUrl = Uri.parse(imageUrl).replace(queryParameters: {
      't': DateTime.now().millisecondsSinceEpoch.toString()
    }).toString();
    onUpload(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () => SharedPrefs.getBool(SharedPrefs.keyPhotoAccess) == true
              ? updatePicture()
              : showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const CustomText(
                      content: 'Allow permission access to the photo library',
                      textOverflow: TextOverflow.visible,
                    ),
                    actions: [
                      CupertinoDialogAction(
                          onPressed: () {
                            updatePicture();
                            Navigator.pop(context);
                            SharedPrefs.setBool(
                                SharedPrefs.keyPhotoAccess, true);
                          },
                          child: const CustomText(
                            content: 'Accept',
                            color: Colors.blue,
                          )),
                      CupertinoDialogAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const CustomText(
                            content: 'No',
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
          child: Badge(
            offset: const Offset(-20, -25),
            padding: const EdgeInsets.all(5.85),
            label: const Icon(Icons.camera_alt_outlined, color: Colors.white),
            backgroundColor: AppColor.globalPink,
            alignment: Alignment.bottomRight,
            child: imageUrl != null
                ? CachedNetworkImage(
                    errorWidget: (context, url, error) => Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[400]),
                          child: const Icon(Icons.person,
                              color: Colors.white, size: 80),
                        ),
                    placeholder: (context, url) => Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[400]),
                          child: const CircularProgressIndicator(
                              color: AppColor.globalPink),
                        ),
                    imageUrl: imageUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover))))
                : Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child:
                        const Icon(Icons.person, color: Colors.white, size: 80),
                  ),
          )),
    );
  }
}
