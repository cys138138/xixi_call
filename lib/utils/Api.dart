import 'package:call/utils/NetHttp.dart';

class Api{
  static final String BASE_HOST = "http://192.168.1.5:8000";
  static final String SOCKET_HOST = "ws://192.168.1.9:8282";

  //username=he.binghan&password=abc222
  //{"code":0,"msg":"\u7528\u6237\u540d\u6216\u5bc6\u7801\u9519\u8bef","avatar":"","token":""}
  //{"code":1,"msg":"\u7528\u6237\u767b\u5f55\u6210\u529f","avatar":"http:\/\/192.168.1.5:8000\/crm\/upload\/avatar\/69.png","token":"901ffdc2eff7169726fbc14a1600b368"}
  static final String LOGIN_URL = "/crm/app/interface.php?action=login&token=";

  //ipt-year=2019&ipt-month=2
  //{"code":1,"all_count":"141","all_duration":"14418","list":[{"date":"19","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"18","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"17","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"16","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"15","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"14","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"13","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"12","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"11","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"10","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"09","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"08","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"07","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"06","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"05","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"04","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"03","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"02","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"},{"date":"01","count":"0","duration":0,"t60":"0","t60_180":"0","t180_360":"0","t360":"0"}],"this_count":0,"this_duration":0,"this_t60":0,"this_t60_180":0,"this_t180_360":0,"this_t360":0}
  static final String GET_CALL_STATISTICS = "/crm/app/interface.php?action=getrecordanalysis&token=901ffdc2eff7169726fbc14a1600b368";


  static Future<dynamic> get(String url, {Map<String, dynamic> data}) async{
    return NetHttp.get(BASE_HOST+url,params: data);
  }

  static Future<dynamic> post(String url, {Map<String, dynamic> data}) async{
    return NetHttp.post(BASE_HOST+url,params: data);
  }


}