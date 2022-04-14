import 'package:flutter/material.dart';

import '../../../app_colors.dart';



class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEBFCFF),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Container(
            width: 2,
            height: MediaQuery.of(context).size.height * 0.04,
            margin: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          const Icon(
            Icons.attach_file,
            color: Colors.green,
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete blood count',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.Blue),
                ),
                Text(
                  '05 Mar 2020',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: AppColors.Blue),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
