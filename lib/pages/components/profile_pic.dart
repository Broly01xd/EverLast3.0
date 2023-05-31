import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: 150,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,

        children: [

          const CircleAvatar(backgroundImage: NetworkImage("https://i.ibb.co/bvHR444/IMG-2925.jpg"),
          ),
          Positioned(

            right: -10,
            bottom: 16,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(

                style: TextButton.styleFrom(backgroundColor: Colors.grey[200],side: const BorderSide(color: Colors.white),padding: EdgeInsets.zero,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)) ),

                onPressed: (){},
                child: SvgPicture.asset("rout/images/icons8-camera (1).svg",

                ),

              ),
            ),
          ),

        ],
      ),
    );
  }
}