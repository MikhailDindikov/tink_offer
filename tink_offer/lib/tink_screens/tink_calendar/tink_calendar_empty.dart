import 'package:flutter/material.dart';

class TinkCalendarEmptyCard extends StatelessWidget {
  const TinkCalendarEmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(36, 36, 36, 1),
            ),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 7,
                  color: const Color.fromRGBO(255, 219, 39, 1),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 30,
                      bottom: 20,
                      left: 13,
                    ),
                    child: Text(
                      'You don’t have any cases today. Do you want to create new one?',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(142, 142, 147, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
