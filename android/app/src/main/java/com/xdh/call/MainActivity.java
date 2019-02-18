package com.xdh.call;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.flyou.test/android";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
//      new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
//              new MethodChannel.MethodCallHandler() {
//                  @Override
//                  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
//                      if (call.method.equals("showToast")) {
//                          if (call.hasArgument("msg") && !TextUtils.isEmpty(call.argument("msg").toString())) {
//                              System.out.println(call.method);
//                              Toast.makeText(MainActivity.this, call.argument("msg").toString(), Toast.LENGTH_SHORT).show();
//                          } else {
//                              Toast.makeText(MainActivity.this, "toast text must not null", Toast.LENGTH_SHORT).show();
//                          }
//                      }
//                      if (call.method.equals("callphone")) {
//                          if (call.hasArgument("mobile") && !TextUtils.isEmpty(call.argument("mobile").toString())) {
//                              callPhone(call.argument("mobile").toString());
//                          } else {
//                              Toast.makeText(MainActivity.this, "mobile must not null", Toast.LENGTH_SHORT).show();
//                          }
//                      }
//                  }
//              });
  }
    public void callPhone(String phoneNum){
        Intent intent = new Intent(Intent.ACTION_CALL);
        Uri data = Uri.parse("tel:" + phoneNum);
        intent.setData(data);
        startActivity(intent);
    }
}

