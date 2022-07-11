import 'dart:math';
import 'dart:ui';
import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/utils/screen_utils.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:animals_adoption_flutter/widgets/custom_back_button.dart';
import 'package:animals_adoption_flutter/widgets/custom_favorite_button.dart';
import 'package:flutter/material.dart';


class AnimalDetailsPage extends StatefulWidget {

  final AnimalModel animal;

  const AnimalDetailsPage({
    Key? key,
    required this.animal,
  }) : super(key: key);

  @override
  State<AnimalDetailsPage> createState() => _AnimalDetailsPageState();
}

class _AnimalDetailsPageState extends State<AnimalDetailsPage> with SingleTickerProviderStateMixin{

  late AnimationController? _animationController;
  late Animation<double>? _animation;


  @override
  void initState() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
    ..addListener(() {
      setState(() {
      });
    });
    _animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final Size _size = MediaQuery.of(context).size;
    final ScreenUtils _screenUtils = ScreenUtils(screenSize: _size);

    final double targetAnimationValue = (_size.height * 0.45) - _screenUtils.bottomPadding;
    final double? dataContainerHeightValue = lerpDouble(_size.height, targetAnimationValue, _animation!.value);
    final double? dataContainerScaleValue = lerpDouble(0.7, 1, _animation!.value);

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.animal.imagePath,
            transitionOnUserGestures: false,
            child: SizedBox(
              height: _size.height * 0.5,
              width: _size.width,
              child: Image.network(
                widget.animal.imagePath,
                fit: BoxFit.fill,                
              ),
            ),
          ),

          Positioned(
            left: _screenUtils.sidesPadding,
            top: _screenUtils.topPadding,
            child: const CustomBackButton()
          ),

          // Data container
          Padding(
            padding: EdgeInsets.only(left: _screenUtils.sidesPadding, right: _screenUtils.sidesPadding),
            child: Transform.scale(
              scale: dataContainerScaleValue!,
              child: Transform.translate(
                offset: Offset(0, dataContainerHeightValue!),
                child: Container(
                  height: _size.height * 0.535,
                  width: _size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: ThemeColors.infoContainerBackgroundGray
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
            
                        // Name, location and favorite button
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.animal.name, style: TextStyles.titleData),
                                    Text(widget.animal.location, style: TextStyles.lightGray14size),
                                  ],
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: CustomFavoriteButton()
                              )
                            ],
                          ),
                        ),
            
                        // Data containers, sex, age and weight
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text('Female', style: TextStyles.lightBlack18size),
                                    Text('Sex', style: TextStyles.lightGray14size),
                                  ],
                                ),
                              ),
                              SizedBox(width: _size.width * 0.035),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text('1 Years', style: TextStyles.lightBlack18size),
                                    Text('Age', style: TextStyles.lightGray14size),
                                  ],
                                ),
                                
                              ),
                              SizedBox(width: _size.width * 0.035),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text('15 Kg', style: TextStyles.lightBlack18size),
                                    Text('Weight', style: TextStyles.lightGray14size),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
            
                        // User data
                        Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Expanded(
                                flex: 1,
                                child:  CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.account_circle_rounded, size: 40)
                                )
                              ),
                              SizedBox(width: _size.width * 0.025),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Francisco', style: TextStyles.lightBlack16size),
                                    Text('${widget.animal.name} owner.', style: TextStyles.lightGray14size),
                                  ],
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child:  Icon(Icons.message_rounded, color: ThemeColors.accent, size: 20)
                              ),
                            ],
                          )
                        ),
            
                        // Show description
                        SizedBox(height: _size.height * 0.02),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Description:', style: TextStyles.lightBlack16size),
                              Text('Vaccinations up to date, spayed / neutered.', style: TextStyles.lightGray14size),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}