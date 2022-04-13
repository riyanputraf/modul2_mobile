import 'package:flutter/material.dart';
import 'shared/listitem.dart';

Widget listWidget(ListItem item){
  return Card(
    elevation: 2.0,
    margin: EdgeInsets.only(bottom: 20.0),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Hero(
            tag: '${item.newsTitle}',
            child: Container(
              width: 100.0,
              height: 90.0,
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: NetworkImage(item.imgUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.newsTitle, style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                ),),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.purpleAccent,),
                    Text(
                      item.author,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),

                    Icon(Icons.star, color: Colors.yellow,size: 28,),
                    Text(
                      item.ratingValue.toString(),
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}