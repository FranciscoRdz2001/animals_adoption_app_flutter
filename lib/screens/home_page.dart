import 'dart:math';

import 'package:animals_adoption_flutter/utils/constants.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:animals_adoption_flutter/widgets/custom_animal_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_category_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_bottom_navigator_bar.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Controllers
  PageController? _categoriesController; 
  PageController? _petsController; 

  // Variables
  int _currentPage = 1;

  @override
  void initState() {

    _categoriesController = PageController(
      initialPage: _currentPage, 
      viewportFraction: 1 / 3,
    )..addListener(() {
      _currentPage = _categoriesController!.page!.round();
    });
    _petsController = PageController(
      initialPage: _currentPage, 
      viewportFraction: 1 / 3,
    );
    super.initState();
  }

  void _onPageChange(int newIndex){
    if(newIndex == _currentPage){
      return;
    }
    setState(() {
      _currentPage = newIndex;
    });
    newIndex = newIndex + (newIndex == 0 ? 1 : newIndex == categories.length - 1 ? -1 : 0);
    _categoriesController!.animateToPage(newIndex, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header
            const Text('Location:', style: TextStyles.titleInformation),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Tijuana, BC MX', style: TextStyles.titleData),
                const Spacer(),
                const Icon(Icons.search_rounded, size: 25, color: ThemeColors.darkGray),
                SizedBox(width: _size.width * 0.05),
                const Icon(Icons.notifications_rounded, size: 25, color: ThemeColors.darkGray)
              ],
            ),

            // Principal Image
            SizedBox(height: _size.height * 0.025),
            Container(
              height: _size.height * 0.15,
              width: _size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: ThemeColors.blueGradient
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Check all the pets available in our application', style: TextStyles.principalContainerTitle)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset(
                        'assets/images/animals/kitty.png', fit: BoxFit.contain,
                        ),
                    ),
                  ),
                ],
              )
            ),
            
            // Body categories
            SizedBox(height: _size.height * 0.015),
            const Text('Categories:', style: TextStyles.bodySubtitle),
            SizedBox(height: _size.height * 0.015),
            SizedBox(
              height: _size.height * 0.175,
              width: _size.width,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                controller: _categoriesController,
                clipBehavior: Clip.none,
                itemBuilder: (_, x){
                  
                  final bool isSelected = _currentPage == x;
                  final double containerScale = isSelected  ? 1.10 : 0.8;
                  
                  return CategoryContainer(
                    onTapFunction: () => _onPageChange(x),
                    backgroundColors: ThemeColors.gradients[x].map((e) => e.withOpacity(0.35)).toList(), 
                    category: categories[x], 
                    scale: containerScale, 
                    isSelected: isSelected
                  );
                },
              ),
            ),

            // Pet list
            SizedBox(height: _size.height * 0.05),
            const Text('Pet list:', style: TextStyles.bodySubtitle),
            SizedBox(
              height: _size.height * 0.175,
              width: _size.width,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _petsController,
                itemCount: animals.length,
                clipBehavior: Clip.none,
                itemBuilder: (_, x){
                  
                  final Color containerColor = ThemeColors.containersBackground[Random().nextInt(ThemeColors.containersBackground.length - 1)].withOpacity(0.25);
                  
                  return CustomAnimalContainer(
                    animal: animals[x], 
                    backgroundColor: containerColor
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigatorBar()
    );
  }
}