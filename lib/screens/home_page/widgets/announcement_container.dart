import 'package:animals_adoption_flutter/models/announcement_model.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class AnnouncementContainer extends StatelessWidget {

  final AnnouncementModel announcement;

  const AnnouncementContainer({
    Key? key,
    required this.announcement
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: _responsive.hp(20),
          width: _responsive.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: ThemeColors.blueGradient
          ),
        ),
        Positioned(
          bottom: _responsive.hp(6.5),
          child: Image.asset(
            announcement.imageURL, 
            fit: BoxFit.contain,
            height: _responsive.hp(30),
            width: _responsive.wp(80),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _responsive.hp(1), vertical: _responsive.wp(2.35)),
          child: Container(
            height: _responsive.hp(10),
            width: _responsive.width,
            padding: EdgeInsets.symmetric(horizontal: _responsive.wp(5), vertical: _responsive.hp(1.5)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ThemeColors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(announcement.title, style: TextStyles.blackSemiBold(_responsive.dp(1.75)), textAlign: TextAlign.center),
                SizedBox(height: _responsive.hp(0.5)),
                Text(announcement.description, style: TextStyles.greySemiBold(_responsive.dp(1.15)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis)
              ],
            ),
          ),
        ),
      ],
    );
  }
}