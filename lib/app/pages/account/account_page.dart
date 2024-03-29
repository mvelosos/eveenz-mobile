import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/accounts_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/pages/account/widgets/follow_button.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_tab_view.dart';
import 'package:party_mobile/app/shared/widgets/account_private_tab_view.dart';
import 'package:party_mobile/app/shared/widgets/profile_bio.dart';
import 'package:party_mobile/app/shared/widgets/profile_popularity_badge.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/widgets/profile_avatar.dart';
import 'package:party_mobile/app/shared/widgets/profile_social_row.dart';
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

  Widget _accountProfileTabView() {
    if (_accountModel != null) {
      if (_accountModel!.uuid == _profileStore.uuid.value) {
        return ProfileTabView();
      }

      if (_accountModel!.privateAccount) {
        if (_accountModel!.followedByMe) {
          return ProfileTabView();
        } else {
          return AccountPrivateTabView();
        }
      } else {
        return ProfileTabView();
      }
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.profileTabViewContainer,
        appBar: AppBar(
          title: Text(
            _loading ? '' : _accountModel!.username,
            style: GoogleFonts.poppins(
              color: AppColors.darkPurple,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: AppColors.orange),
        ),
        body: RefreshIndicator(
          color: AppColors.orange,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          displacement: 0,
          onRefresh: () async {
            await _getAccount();
          },
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: _size.height * .015),
                  ProfileAvatar(_accountModel?.avatarUrl),
                  SizedBox(height: _size.height * .03),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: AutoSizeText(
                      _accountModel == null ? '' : _accountModel!.name,
                      minFontSize: 17,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(height: _size.height * .02),
                  ProfilePopularityBadge(_accountModel?.popularity),
                  SizedBox(height: _size.height * .02),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: ProfileBio(_accountModel?.bio),
                  ),
                  ProfileSocialRow(
                    context: context,
                    username: _accountModel?.username ?? '',
                    eventsCount: _accountModel?.events ?? 0,
                    followersCount: _accountModel?.followers ?? 0,
                    followingCount: _accountModel?.following ?? 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _showFollowButton
                          ? FollowButton(_accountModel!, _getAccount)
                          : SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: _size.height * .025),
                  _accountProfileTabView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
