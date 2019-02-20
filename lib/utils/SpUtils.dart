import 'package:call/OsApplication.dart';
import 'package:call/bean/UserInfoBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SpUtils {
  static const SP_ID = 'sp_id';
  static const SP_NAME = 'sp_name';
  static const SP_TOKEN = 'sp_token';
  static const AVATAR = 'avatar';

  static const SP_TOKEN_TYPE = 'sp_token_type';
  static const SP_EXPIRES_IN = 'sp_expires_in';

  static const SP_COOKIE = 'sp_cookie';

// 保存用户信息
  static void saveUserInfo(UserInfoBean userInfo) async {
    if (userInfo != null) {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setString(SP_ID, userInfo.id.toString());
      sharedPreferences.setString(SP_NAME, userInfo.username);
      sharedPreferences.setString(SP_TOKEN, userInfo.token);
      sharedPreferences.setString(AVATAR, userInfo.avatar);
    }
  }

// 清除用户信息
  static void cleanUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SP_ID, null);
    sharedPreferences.setString(SP_NAME, null);
    sharedPreferences.setString(SP_TOKEN, null);
    sharedPreferences.setString(AVATAR, null);
    saveCookie(null);
    OsApplication.cookie=null;
  }

//  获取用户信息
  static Future<UserInfoBean> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString(SP_ID);
    var name = sharedPreferences.getString(SP_NAME);
    var token = sharedPreferences.getString(SP_TOKEN);
    var avatar = sharedPreferences.getString(AVATAR);
    UserInfoBean userInfoBean = new UserInfoBean(id, name, token,avatar);
    return userInfoBean;
  }

//  把map转为UserInfoBean
  static Future<UserInfoBean> map2UserInfo(Map map) async {
    print(map);
    if (map != null) {
      var id = map['user_id'];
      var name = map['nickname'];
      var token = map['token'];
      var avatar = map['avatar'];
      UserInfoBean userInfoBean = new UserInfoBean(id, name, token,avatar);
      return userInfoBean;
    } else {
      return null;
    }
  }

//  保存token等信息
  static void saveTokenInfo(Map map) async {
    if (map != null) {
      var tokenType = map['token_type'];
      var expiresIn = map['expires_in'];

      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(SP_TOKEN_TYPE, tokenType);
      sp.setString(SP_EXPIRES_IN, expiresIn.toString());
    }
  }

  static void saveCookie(var cookie) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SP_COOKIE, cookie);
  }

  static Future<String> getCookie() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var cookieStr = sharedPreferences.getString(SP_COOKIE);
    return cookieStr;
  }
}