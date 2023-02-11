import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tower_box_test/model/box.model.dart';
import 'package:tower_box_test/widget/button.circle.widget.dart';
import 'package:tower_box_test/widget/triangle.container.widget.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<BoxModel> boxList = [];
  int numberDestroy = 0, maxBox = 5, _startTime = 2, _totalTime = 0;
  Timer? timer, totalTimer;
  bool isShowTime = false,
      isLeft = false,
      isRight = false,
      isStop = false,
      isStart = true;
  String txtShow = '';
  Size sizeLastBox = const Size(0, 0), sizeTriangle = const Size(24, 24);

  @override
  void initState() {
    setStart();
    super.initState();
  }

  void setStart() {
    isShowTime = false;
    isLeft = false;
    isRight = false;
    isStop = false;
    isStart = true;
    _totalTime = 0;
    int i = 0;
    do {
      i++;
      Color color = const Color(0XFFF9DFFF);
      int randome = math.Random().nextInt(3);
      if (randome > 1) {
        color = const Color(0XFF90E5FF);
      }

      boxList.add(
        BoxModel(
          widget: Container(
            width: 30,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              border: Border.all(
                color: const Color(0xFF707070),
                width: 1,
              ),
            ),
          ),
          color: color,
        ),
      );
    } while (i < maxBox);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          sizeLastBox = Size(
            MediaQuery.of(context).size.width / 3.9,
            MediaQuery.of(context).size.width / 3.9,
          );
        } else {
          sizeLastBox = Size(
            MediaQuery.of(context).size.width / 3,
            MediaQuery.of(context).size.width / 3,
          );
        }
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    orientation == Orientation.landscape
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                            child: ButtonCircleWidget(
                              color: const Color(0XFFF9DFFF),
                              onPressed: () {
                                isLeft = true;
                                startTimer(const Color(0XFFF9DFFF));
                              },
                              onLongPressUp: () {
                                isLeft = false;
                                cancleTimer(const Color(0XFFF9DFFF));
                              },
                            ),
                          )
                        : Container(),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        color: const Color(0XFFD8D8D8),
                        padding: EdgeInsets.symmetric(
                          horizontal: orientation == Orientation.landscape
                              ? MediaQuery.of(context).size.width / 4.5
                              : MediaQuery.of(context).size.width / 4,
                        ),
                        child: ListView(
                          reverse: true,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(4),
                          children: boxList
                              .asMap()
                              .map(
                                (index, element) => MapEntry(
                                  index,
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Stack(
                                            children: numberDestroy == index
                                                ? [
                                                    CustomPaint(
                                                      size: sizeTriangle,
                                                      painter:
                                                          DrawTriangleStroke(),
                                                    ),
                                                    CustomPaint(
                                                      size: sizeTriangle,
                                                      painter:
                                                          DrawTriangleFill(),
                                                    ),
                                                  ]
                                                : [
                                                    SizedBox(
                                                      width: sizeTriangle.width,
                                                      height:
                                                          sizeTriangle.height,
                                                    )
                                                  ],
                                          ),
                                        ),
                                        Expanded(
                                            child: index == boxList.length - 1
                                                ? Stack(
                                                    children: [
                                                      CustomPaint(
                                                        size: sizeLastBox,
                                                        painter:
                                                            DrawDiamondFill(),
                                                      ),
                                                      CustomPaint(
                                                        size: sizeLastBox,
                                                        painter:
                                                            DrawDiamondStroke(),
                                                      ),
                                                    ],
                                                  )
                                                : element.widget!),
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Stack(
                                            children: numberDestroy == index
                                                ? [
                                                    CustomPaint(
                                                      size: sizeTriangle,
                                                      painter:
                                                          DrawTriangleStroke(
                                                              isLeft: false),
                                                    ),
                                                    CustomPaint(
                                                      size: sizeTriangle,
                                                      painter: DrawTriangleFill(
                                                          isLeft: false),
                                                    ),
                                                  ]
                                                : [
                                                    SizedBox(
                                                      width: sizeTriangle.width,
                                                      height:
                                                          sizeTriangle.height,
                                                    )
                                                  ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .values
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
                              onPressed: () {
                                isRight = true;
                                startTimer(const Color(0XFF90E5FF));
                              },
                              onLongPressUp: () {
                                isRight = false;
                                cancleTimer(const Color(0XFF90E5FF));
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: isShowTime
                      ? SizedBox(
                          width: double.infinity,
                          child: Text(
                            txtShow != ''
                                ? txtShow
                                : '${_startTime.toString()} วินาที',
                            style: const TextStyle(
                              fontSize: 36,
                              color: Colors.black54,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(),
                ),
                Positioned.fill(
                  child: isStop
                      ? Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                setStart();
                              });
                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'เริ่มใหม่',
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
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
                          onPressed: () {
                            isLeft = true;
                            startTimer(const Color(0XFFF9DFFF));
                          },
                          onLongPressUp: () {
                            isLeft = false;
                            cancleTimer(const Color(0XFFF9DFFF));
                          },
                        ),
                        ButtonCircleWidget(
                          color: const Color(0XFF90E5FF),
                          onPressed: () {
                            isRight = true;
                            startTimer(const Color(0XFF90E5FF));
                          },
                          onLongPressUp: () {
                            isRight = false;
                            cancleTimer(const Color(0XFF90E5FF));
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  void startTimer(Color color) {
    setState(() {
      isShowTime = true;
    });

    /// เช็คกล่องว่าหมดหรือยัง
    if (boxList.isEmpty) {
      txtShow = 'กล่องหมดแล้ว';
    }

    /// เช็คการกดปุ่มของกล่องสุดท้าย
    else if (boxList.length == 1 && (isLeft != true || isRight != true)) {
      txtShow = 'กดสองปุ่มพร้อมกัน';
    } else if ((boxList.length == 1 && isLeft == true && isRight == true)) {
      txtShow = '';
      timerFnc();
    }

    /// เช็คการกดปุ่มสองปุ่มพร้อมกัน
    else if ((boxList.length > 1 && isLeft == true && isRight == true)) {
      txtShow = 'กดเพียงปุ่มเดียว';
    }

    /// เช็คการกดปุ่มถูกสีไหม
    else if (color != boxList[0].color) {
      txtShow = 'สีไม่ถูกต้อง';
    } else if (boxList.isNotEmpty) {
      txtShow = '';
      timerFnc();
    }
  }

  void timerFnc() {
    if (isStart == true) {
      startTotalTimer();
      isStart = false;
    }
    _startTime = 2;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_startTime == 1) {
          boxList.removeAt(0);
          if (boxList.isEmpty) {
            txtShow = 'กล่องหมดแล้ว';
            isStop = true;
          } else {
            isShowTime = false;
          }
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _startTime--;
          });
        }
      },
    );
  }

  void cancleTimer(Color color) {
    setState(() {
      if (boxList.isNotEmpty) {
        isShowTime = false;
        timer?.cancel();
      }
    });
  }

  void startTotalTimer() {
    const oneSec = Duration(seconds: 1);
    totalTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (isStop == true) {
          setState(() {
            txtShow += '\nใช้เวลาทั้งหมด\n $_totalTime วินาที';
          });
          timer.cancel();
        } else {
          _totalTime++;
        }
      },
    );
  }
}
