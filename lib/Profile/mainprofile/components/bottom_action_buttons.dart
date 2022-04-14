import 'package:flutter/material.dart';
import 'package:plantholic/NetworkHandler.dart';
import 'package:plantholic/Pages/ForgetPassword.dart';

import '../../../app_colors.dart';
import '../../Updateprofile.dart';

class BottomActionButtons extends StatefulWidget {
  const BottomActionButtons({
    Key key,
  }) : super(key: key);

  @override
  State<BottomActionButtons> createState() => _BottomActionButtonsState();
}

class _BottomActionButtonsState extends State<BottomActionButtons> {
  NetworkHandler networkHandler =NetworkHandler();
  String name ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => UpdateProfile()));
                  },
                  color: AppColors.Green,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        // letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.Grey,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16 / 2),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () async {
                  var response = await networkHandler.get("/profile/checkProfile");
                  name = response["username"];
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => EditPassword(name:name)));
                  },
                  color: AppColors.Grey,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: AppColors.Green, width: 2),
                  ),
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.Green,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
