import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_buttons.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

class CheckpointDetailPage extends StatefulWidget {
  final String id;
  final String trailid;
  const CheckpointDetailPage({super.key, required this.id, required this.trailid});

  @override
  State<CheckpointDetailPage> createState() => _CheckpointDetailPageState();
}

class _CheckpointDetailPageState extends State<CheckpointDetailPage> {
  final int _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: IconButton(
                          icon:  const  Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                    const AppText(
                      text: 'Chommrung',
                      fontSize: 20,
                      color: AppColor.primaryDarkColor,
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  width: 330,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.primaryLightColor),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: const Image(
                      image: AssetImage('assets/images/EBC.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: AppText(
                              text: 'Altitude',
                              fontSize: 17,
                              color: AppColor.primaryDarkColor,
                            ),
                          ),
                          AppText(
                            text: '2550 m',
                            fontSize: 15,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(bottom: 10.0),
                            child: AppText(
                              text: 'Lodges',
                              fontSize: 17,
                              color: AppColor.primaryDarkColor,
                            ),
                          ),
                          AppText(
                            text: '10',
                            fontSize: 15,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: AppText(
                              text: 'Network',
                              fontSize: 17,
                              color: AppColor.primaryDarkColor,
                            ),
                          ),
                          AppText(
                            text: 'Available',
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: AppButtons(
                      width: 200,
                      onPressed: () {},
                      child: const AppText(
                        text: 'Weather',
                      )),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                const Center(
                  child: AppText(
                    text: 'Lodges',
                    color: AppColor.primaryDarkColor,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 10, right: 20),
                  child: SizedBox(
                    height: 800,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        shrinkWrap: false,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: ((context, index) {
                          return InkWell(
                            child: Container(
                              height: 165,
                              width: 159,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/EBC.jpg'),
                                      fit: BoxFit.cover),
                                  color: Colors.amber),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.8),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const AppText(
                                      text: 'Hamro Logde',
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: AppText(
                                            text: '9012345678',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0, right: 15),
                                      child: AnimatedPositioned(
                                        duration: const Duration(milliseconds: 300),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: List.generate(
                                              5,
                                              (index) => SizedBox(
                                                height: 15,
                                                width: 20,
                                                child: IconButton(
                                                  icon: index < _rating
                                                      ? const Icon(Icons.star,
                                                          size: 22)
                                                      : const Icon(Icons.star_border,
                                                          size: 22),
                                                  color: const Color.fromARGB(
                                                      255, 223, 170, 10),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {},
                          );
                        })),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
