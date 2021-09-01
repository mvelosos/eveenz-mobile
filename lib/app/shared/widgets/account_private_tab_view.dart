import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class AccountPrivateTabView extends StatelessWidget {
  const AccountPrivateTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.profileTabViewContainer,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(
                    FontAwesomeIcons.calendarAlt,
                    size: 20,
                    color: AppColors.gray4,
                  ),
                  FaIcon(
                    FontAwesomeIcons.commentAlt,
                    size: 20,
                    color: AppColors.gray4,
                  ),
                ],
              ),
            ),
            Divider(thickness: 2),
            SizedBox(height: 50),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: AppColors.gray4),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.lock,
                  size: 20,
                  color: AppColors.gray4,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Esse perfil é privado!',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.gray3,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 240,
              child: Text(
                'Você precisar ser aceito para ver os eventos e publicações desse perfil',
                style: TextStyle(color: AppColors.gray3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
