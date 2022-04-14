import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantholic/Model/profileModel.dart';
import 'package:plantholic/app_colors.dart';

import '../../../NetworkHandler.dart';

class TopHeader extends StatefulWidget {
  const TopHeader({Key key, this.profileModel}) : super(key: key);
  final ProfileModel profileModel;

  @override
  State<TopHeader> createState() => _TopHeaderState();
}

class _TopHeaderState extends State<TopHeader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.43,
      child: Stack(
        children: [
          /// Background and Date
          Container(
            padding: const EdgeInsets.all(32),
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.Green,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  150,
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
          Positioned(
            bottom: 0,
            left: 32,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(72),
                    border: Border.all(
                      color: Colors.white,
                      width: 8,
                    ),
                  ),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(72),
                        child: widget.profileModel.img == null
                            ? CircularProgressIndicator(
                                color: AppColors.Green,
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: imageFromBase64String(
                                    widget.profileModel.img),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Container(
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: AppColors.GreenA,
                //     shape: BoxShape.circle,
                //     border: Border.all(
                //       color: Colors.white,
                //       width: 8,
                //     ),
                //   ),
                //   child: const Icon(Icons.person, color: Colors.white),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }

  MemoryImage imageFromBase64String(String base64String) {
    return MemoryImage(base64.decode(base64String));
  }
}
