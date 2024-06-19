part of 'profile_page.dart';

Container nullAvatar() {
  return Container(
    alignment: Alignment.center,
    width: 88,
    height: 88,
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[400]),
    child: const Icon(Icons.person, color: Colors.white, size: 80),
  );
}

Column avatarAndName(String? avatar, String? name) {
  return Column(
    children: [
      avatar != null
          ? CachedNetworkImage(
              errorWidget: (context, url, error) => Container(
                  alignment: Alignment.center,
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[400]),
                  child:
                      const Icon(Icons.person, color: Colors.white, size: 80)),
              placeholder: (context, url) => Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const CircularProgressIndicator(
                        color: AppColor.globalPink),
                  ),
              imageUrl: avatar,
              imageBuilder: (context, imageProvider) => Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ))
          : nullAvatar(),
      Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4),
        child: CustomText(
            content: name ?? '', fontSize: 20, fontWeight: FontWeight.w700),
      )
    ],
  );
}
