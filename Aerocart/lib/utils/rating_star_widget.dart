import 'package:flutter/material.dart';

class RatingStatWidget extends StatelessWidget {
  final int? rating;
  const RatingStatWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if(rating==null){
      for (int i = 0; i < 5; i++) {
      children.add(const Icon(Icons.star_border, color: Colors.orange));
    }
    }
    else{
    for (int i = 0; i < 5; i++) {
      children.add(i < rating!
          ? const Icon(
              Icons.star,
              color: Colors.orange,
            )
          : const Icon(Icons.star_border, color: Colors.orange));
    }
    }

    return Row(
      children: children,
    );
  }
}