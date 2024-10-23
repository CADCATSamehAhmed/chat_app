import 'dart:async';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/functions/my_custom_color.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/status/data/models/statuses_model.dart';
import 'package:chat_app/features/status/presentation/view_model/status_cubit.dart';
import 'package:chat_app/features/status/presentation/views/widgets/reply_row.dart';
import 'package:chat_app/features/status/presentation/views/widgets/status_appbar.dart';
import 'package:chat_app/features/status/presentation/views/widgets/status_linear_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ShowStatusBody extends StatefulWidget {
  final StatusesModel statuses;

  const ShowStatusBody({super.key, required this.statuses});

  @override
  State<ShowStatusBody> createState() => _ShowStatusBodyState();
}

class _ShowStatusBodyState extends State<ShowStatusBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;
  double _progress = 0.0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    int duration = widget.statuses.statuses[_currentPage].statusPlayTime;
    _timer =
        Timer.periodic(Duration(milliseconds: duration * 10), (Timer timer) {
      if (!_isPaused) {
        setState(() {
          _progress += 0.01;
          if (_progress >= 0.99) {
            _progress = 0.0;
            if (_currentPage < widget.statuses.statuses.length - 1) {
              _currentPage++;
              _pageController.animateToPage(
                _currentPage,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            } else {
              StatusCubit.get(context).makeStatusWatched(widget.statuses);
              _timer.cancel();
              Get.back();
            }
          }
        });
      }
    });
  }

  void pauseTimer() {
    setState(() {
      _isPaused = true;
    });
  }

  void resumeTimer() {
    setState(() {
      _isPaused = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatusCubit, StatusStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              Get.back();
              return true;
            },
            child: Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _progress = 0.0;
                      if (_currentPage < widget.statuses.statuses.length - 1) {
                        _currentPage++;
                        _pageController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      } else {
                        StatusCubit.get(context).makeStatusWatched(widget.statuses);
                        _timer.cancel();
                        Get.back();
                      }
                    });
                  },
                  onTapDown: (_) => pauseTimer(),
                  onTapUp: (_) => resumeTimer(),
                  onTapCancel: () => resumeTimer(),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                        _progress = 0.0;
                      });
                    },
                    itemCount: widget.statuses.statuses.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * .02,
                            screenHeight * .02,
                            screenWidth * .02,
                            screenHeight * .04),
                        decoration: BoxDecoration(
                            color: MyCustomColor.getStatusBgColor(widget
                                    .statuses
                                    .statuses[index]
                                    .textBGColorIndex) ??
                                Colors.black,
                            image: widget.statuses.statuses[index].media != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                        widget.statuses.statuses[index].media!),
                                    fit: BoxFit.contain,
                                  )
                                : null),
                        child: Stack(
                          children: [
                            StatusAppbar(
                              statuses: widget.statuses,
                              statusDate: widget.statuses.statuses[index].date,
                            ),
                            if (widget.statuses.statuses[index].text != null)
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
                                  child: Text(
                                    widget.statuses.statuses[index].text!,
                                    textAlign: TextAlign.center,
                                    maxLines: 10,
                                    style: Fonts.font25.copyWith(
                                        color: Colors.white,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                            if (widget.statuses.statuses[index].mediaDescription != null)
                              Positioned(
                                bottom: 50,
                                left: 10,
                                right: 10,
                                child: Text(
                                  widget.statuses.statuses[index].mediaDescription!,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: Fonts.font18.copyWith(
                                      color: Colors.white,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                StatusLinearIndicator(
                    totalSegments: widget.statuses.statuses.length,
                    currentPageIndex: _currentPage,
                    progress: _progress),
                const ReplyRow(),
              ],
            ),
          );
        });
  }
}
