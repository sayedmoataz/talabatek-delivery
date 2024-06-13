// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../bloc/Cubit/AppCubit.dart';

class CardColumnScreen extends StatefulWidget {
  CardColumnScreen({Key? key}) : super(key: key);

  @override
  _CardColumnScreenState createState() => _CardColumnScreenState();
}

class _CardColumnScreenState extends State<CardColumnScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoRefresh(
      duration: const Duration(milliseconds: 2000),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: MediaQuery.of(context).size.width / 2,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    EmptyCard(
                      width: MediaQuery.of(context).size.width,
                      height: 166.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const EmptyCard(height: 50.0, width: 50.0),
                          const EmptyCard(height: 50.0, width: 50.0),
                          const EmptyCard(height: 50.0, width: 50.0),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Flexible(child: EmptyCard(height: 150.0)),
                        const Flexible(child: EmptyCard(height: 150.0)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Flexible(child: EmptyCard(height: 50.0)),
                          const Flexible(child: EmptyCard(height: 50.0)),
                          const Flexible(child: EmptyCard(height: 50.0)),
                        ],
                      ),
                    ),
                    EmptyCard(
                      width: MediaQuery.of(context).size.width,
                      height: 166.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: 100,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 170.h,
                          childAspectRatio: 1,
                          mainAxisSpacing: 42,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 44.0,
                              child: FadeInAnimation(
                                child: EmptyCard(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60.h,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListLoading extends StatelessWidget {
  double? height;
  double? width;
  Axis? scroll;
  ListLoading({this.height, this.scroll, this.width});

  @override
  Widget build(BuildContext context) {
    return AutoRefresh(
      duration: const Duration(milliseconds: 3000),
      child: Scaffold(
        body: SafeArea(
          child: AnimationLimiter(
            child: GridView.builder(
              scrollDirection: scroll ?? Axis.vertical,
              padding: const EdgeInsets.all(8.0),
              itemCount: 100,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .73,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child: EmptyCard(
                        width: width ?? MediaQuery.of(context).size.width,
                        height: height,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class VListLoading extends StatelessWidget {
  double? height;
  double? width;
  Axis? scroll;
  VListLoading({this.height, this.scroll, this.width});

  @override
  Widget build(BuildContext context) {
    return AutoRefresh(
      duration: const Duration(milliseconds: 3000),
      child: Scaffold(
        body: SafeArea(
          child: AnimationLimiter(
            child: GridView.builder(
              scrollDirection: scroll ?? Axis.vertical,
              padding: const EdgeInsets.all(8.0),
              itemCount: 100,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3.73,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child: EmptyCard(
                        width: width ?? MediaQuery.of(context).size.width,
                        height: height,
                        color: AppCubit.get(context).themeMode == true
                            ? Colors.grey[800]
                            : Colors.grey[500]!.withOpacity(0.2),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AutoRefresh extends StatefulWidget {
  final Duration duration;
  final Widget child;

  AutoRefresh({
    Key? key,
    required this.duration,
    required this.child,
  }) : super(key: key);

  @override
  _AutoRefreshState createState() => _AutoRefreshState();
}

class _AutoRefreshState extends State<AutoRefresh> {
  int? keyValue;
  ValueKey? key;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    keyValue = 0;
    key = ValueKey(keyValue);

    _recursiveBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }

  void _recursiveBuild() {
    _timer = Timer(
      widget.duration,
      () {
        setState(() {
          keyValue = keyValue! + 1;
          key = ValueKey(keyValue);
          _recursiveBuild();
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class EmptyCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const EmptyCard({
    Key? key,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
/*      child: Text("Loading...",
        style: englishStyle(
          size: 14,
          fontWeight: FontWeight.w500,
          color:Colors.black45 ,
          spacing:2.5
        ),
        textAlign: TextAlign.center,),*/
      decoration: BoxDecoration(
        color: AppCubit.get(context).themeMode == true
            ? Colors.grey[800]
            : Colors.grey[300],
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
    );
  }
}
