import 'package:amazon_clone/auth/user_details_model.dart';
import 'package:amazon_clone/login_screens/user_details.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;
  UserDetailsBar({
    super.key,
    required this.offset,
  });
  final List<Color> userdetailscolor = [
    const Color.fromARGB(255, 192, 211, 156),
    const Color.fromARGB(223, 55, 63, 61)
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userdetails;
    return Positioned(
      top: -offset / 4,
      child: Container(
        height: 40,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: userdetailscolor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.grey[800],
              ),
              SizedBox(
                width: width * 0.7,
                child:userDetailsModel.name!="loading"&&userDetailsModel.address!="loading"? GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserDetails()));
                  },
                  child: Text(
                    "Deliver to ${userDetailsModel.name}-${userDetailsModel.address}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ):
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserDetails()));
                  },
                  child: Text(
                    "Add Address for better experience",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
