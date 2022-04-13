import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:modul1_old/rating_view.dart';
import 'package:modul1_old/shared/listitem.dart';

class DetailsScreen extends StatefulWidget {
  final String tag;
  final ListItem item;

  DetailsScreen({Key? key, required this.item, required this.tag})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  //const DetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                      tag: '${widget.item.newsTitle}',
                      child: Image.network(widget.item.imgUrl)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.item.newsTitle,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.purpleAccent,
                              size: 30,
                            ),
                            Text(
                              widget.item.author,
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RatingBar(
                                initialRating: widget.item.ratingValue,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemSize: 30.0,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star,
                                        color: Colors.orange),
                                    half: const Icon(
                                      Icons.star_half,
                                      color: Colors.orange,
                                    ),
                                    empty: const Icon(
                                      Icons.star_outline,
                                      color: Colors.red,
                                    )),
                                onRatingUpdate: (value)  async {
                                  widget.item.ratingValue = value;

                                  setState(() {
                                    widget.item.ratingValue = value;
                                  });
                                }),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '${widget.item.ratingValue}',
                              style: TextStyle(fontSize: 20.0),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextButton.icon(
                          onPressed: ()   {
                               openRatingDialog(context);


                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.withOpacity(0.1))
                          ),
                          icon: Icon(Icons.star),
                          label: Text(
                            'Rate Here',
                            style: TextStyle(fontSize: 20, color: Colors.black),


                          ),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          lipsum.createParagraph(numParagraphs: 3),
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context, widget.item.ratingValue);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

   openRatingDialog(BuildContext context) async {

    var result = await showDialog(
       context: context,
       builder: (context) {
         return Dialog(
           child: RatingView(item: widget.item,),

         );
       },

     );

    if(result != null)
      setState(() {
        widget.item.ratingValue = result!;
      });

   }
}
