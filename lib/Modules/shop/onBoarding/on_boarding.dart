import 'package:flutter/material.dart';
import 'package:shop_app/Modules/shop/login/login.dart';
import 'package:shop_app/Shared/Network/local/shared_preference.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body')
  ];
  bool isLast = false;
  var boardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text('SKIP')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return buildOnBoardingItem(boarding[index]);
                },
                itemCount: 3,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset(model.image)),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );



  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value!)
      {
        //if can true save
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  ShopLogInScreen()));
      }
    });

  }
}

