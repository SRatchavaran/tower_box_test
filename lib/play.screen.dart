import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tower_box_test/widget/button.circle.widget.dart';
import 'package:tower_box_test/widget/triangle.container.widget.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<Color> colorList = [];

  @override
  void initState() {
    int i = 1;
    do {
      i++;
      Color color = const Color(0XFFF9DFFF);
      int randome = Random().nextInt(3);
      if (randome > 1) {
        color = const Color(0XFF90E5FF);
      }

      colorList.add(color);
    } while (i < 10);
    colorList.add(Colors.black);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              orientation == Orientation.landscape
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: ButtonCircleWidget(
                        color: const Color(0XFFF9DFFF),
                        onPressed: () {},
                      ),
                    )
                  : Container(),
              Expanded(
                child: Container(
                  color: const Color(0XFFD8D8D8),
                  padding: EdgeInsets.symmetric(
                    horizontal: orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.width / 4
                        : MediaQuery.of(context).size.width / 3,
                  ),
                  child: GridView.count(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    primary: false,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    crossAxisCount: 1,
                    childAspectRatio: 2,
                    children: colorList
                        .map(
                          (e) => Row(
                            children: [
                              CustomPaint(
                                  size: Size(20, 20),
                                  painter: DrawTriangleShape()),
                              Container(
                                decoration: BoxDecoration(
                                  color: e,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                    color: const Color(0xFF707070),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              orientation == Orientation.landscape
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: ButtonCircleWidget(
                        color: const Color(0XFF90E5FF),
                        onPressed: () {},
                      ),
                    )
                  : Container(),
            ],
          ),
          bottomNavigationBar: orientation == Orientation.landscape
              ? null
              : Container(
                  color: Colors.white,
                  height: 104,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonCircleWidget(
                        color: const Color(0XFFF9DFFF),
                        onPressed: () {},
                      ),
                      ButtonCircleWidget(
                        color: const Color(0XFF90E5FF),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
