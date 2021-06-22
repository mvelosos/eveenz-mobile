import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/accounts_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/shared/widgets/profile_popularity_badge.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/widgets/profile_avatar.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

// Page Arguments
class AccountPageArguments {
  final String username;

  AccountPageArguments({required this.username});
}

// Page
class AccountPage extends StatefulWidget {
  final AccountPageArguments args;

  AccountPage({required this.args});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AccountsController _accountsController = locator<AccountsController>();
  final ProfileStore _profileStore = locator<ProfileStore>();
  AccountModel? _accountModel;
  bool _loading = true;
  bool _showFollowButton = false;

  // Functions

  @override
  void initState() {
    super.initState();
    _getAccount();
  }

  Future<void> _getAccount() async {
    var result = await _accountsController.getAccount(widget.args.username);
    if (result.isRight()) {
      setState(() {
        _accountModel = result.getOrElse(() => {} as AccountModel);
        _shouldShowFollowButton();
        _loading = false;
      });
    }
  }

  void _shouldShowFollowButton() {
    if (_accountModel!.uuid != _profileStore.uuid.value) {
      _showFollowButton = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    final _navigationService = NavigationService.currentNavigator(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                _loading ? '' : _accountModel!.username,
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: Colors.blue),
            ),
            body: RefreshIndicator(
              color: AppColors.orange,
              displacement: 0,
              onRefresh: () async {
                await _getAccount();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Container(
                  color: Colors.white,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: _size.width * .06,
                          right: _size.width * .06,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: _size.height * .03),
                            ProfileAvatar(_accountModel?.avatarUrl),
                            SizedBox(height: _size.height * .03),
                            AutoSizeText(
                              _accountModel == null ? '' : _accountModel!.name,
                              minFontSize: 17,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: _size.height * .02),
                            ProfilePopularityBadge(_accountModel?.popularity),
                            SizedBox(height: _size.height * .02),
                            // ProfileBio(),
                            // ProfileSocialRow(_navigationService)
                          ],
                        ),
                      ),
                      SizedBox(height: _size.height * .03),
                      // ProfileTabView()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
