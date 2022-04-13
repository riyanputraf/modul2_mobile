import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modul1_old/shared/listitem.dart';

class RatingView extends StatefulWidget {
  final ListItem item;

  const RatingView({Key? key, required this.item}) : super(key: key);

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  var _ratingPageController = PageController();
  var _starPosition = 200.0;
  var _rating = 0;
  var _selectedChipIndex = -1;
  var _isMoreDetailActive = false;
  var _moreDetailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    /*ListItem listItem = ListItem(_rating);*/
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          //Thanks Note
          Container(
            height: max(300, MediaQuery.of(context).size.height * 0.3),
            child: PageView(
              controller: _ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(),
              ],
            ),
          ),
          //Done Button
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.purpleAccent,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context, widget.item.ratingValue);
                  },
                  child: Text('Done'),
                  textColor: Colors.white,
                ),
              )),
          //Skip Button
          Positioned(
              right: 0,
              child: MaterialButton(
                onPressed: () {
                  if(Navigator.canPop(context))
                    Navigator.pop(context);
                },
                child: Text('Skip'),
              )),
          AnimatedPositioned(
            top: _starPosition,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar(
                    initialRating: widget.item.ratingValue,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 30.0,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.red,
                        )),
                    onRatingUpdate: (value) {
                      _ratingPageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      setState(() {
                        _starPosition = 20.0;
                        widget.item.ratingValue = value;
                      });
                    }),
              ],

            ),
            duration: Duration(milliseconds: 300),
          ),
          if(_isMoreDetailActive)
          Positioned(
              left: 0,
              top: 0,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _isMoreDetailActive = false;
                  });
                },
                child: Icon(Icons.arrow_back_ios),
              ))
        ],
      ),
    );
  }

  _buildThanksNote() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Thank You Fo Reading >_<',
          style: TextStyle(
            fontSize: 24,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text('Please leave your feedback'),
      ],
    );
  }

  _causeOfRating() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !_isMoreDetailActive,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bagimana Pendapat Anda ?'),
              Wrap(
                spacing: 8.0,
                alignment: WrapAlignment.center,
                children: List.generate(
                    6,
                    (index) => InkWell(
                          onTap: () {
                            setState(() {
                              _selectedChipIndex = index;
                            });
                          },
                          child: Chip(
                            backgroundColor: _selectedChipIndex == index
                                ? Colors.lightBlueAccent
                                : Colors.grey[300],
                            label: Text('Option ${index}'),
                          ),
                        )),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  _moreDetailFocusNode.requestFocus();
                  setState(() {
                    _isMoreDetailActive = true;
                  });
                },
                child: Text(
                  'Want to tell us ?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tell Us',
              ),
              Chip(
                label: Text('Text ${_selectedChipIndex + 1}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  focusNode: _moreDetailFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Write Your Review...',
                    hintStyle: TextStyle(
                      color: Colors.purpleAccent,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
