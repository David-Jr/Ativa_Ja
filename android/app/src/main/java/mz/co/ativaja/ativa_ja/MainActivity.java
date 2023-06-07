package mz.co.ativaja.ativa_ja;


import android.Manifest;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.telephony.SubscriptionInfo;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String ENCODED_HASH = Uri.encode("#");
    //    private static final String CHANNEL = "samples.flutter.dev/battery";
    private static final String TO_NATIVE_CHANNEL = "ativaja.co.mz/ussd_channel/to_native";
    private static final String TO_FLUTTER_CHANNEL = "ativaja.co.mz/ussd_channel/native_to_flutter";
    private static final String TAG = "TAGGGG";

    private MethodChannel toFlutterChannel;

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        // handle READ_PHONE_STATE permission result
        if (requestCode == 1) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // permission granted
                Log.d(TAG, "onRequestPermissionsResult: permission granted");
            } else {
                // permission denied
                Log.d(TAG, "onRequestPermissionsResult: permission denied");
            }
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), TO_NATIVE_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            switch (call.method) {
                                case "executeUSSD":
                                    executeUSSD(call.argument("ussdCode"), call.argument("fullRoute"), call.argument("carrierName"));
                                    break;

                                case "isServiceEnabled":
                                    if (isServiceEnabled(MainActivity.this, MyAccessibilityService.class)) {
                                        result.success(true);
                                    } else {
                                        result.success(false);
                                    }
                                    break;

                                case "enableService":
                                    enableService();
                                    break;

                                default:
                                    result.notImplemented();
                                    break;
                            }
                        }
                );

        this.toFlutterChannel = new MethodChannel(
                flutterEngine.getDartExecutor().getBinaryMessenger(),
                TO_FLUTTER_CHANNEL);
    }

    @Override
    @Deprecated
    public boolean onKeyLongPress(int keyCode, KeyEvent event) {
        //todo: Check if volume up key is long pressed
        //todo: Send info to flutter side via method channel
        // reference: https://stackoverflow.com/questions/68689778/how-to-override-power-and-volume-buttons-in-flutter
        if (keyCode == KeyEvent.KEYCODE_VOLUME_UP) {
            Toast.makeText(this, "Volume Up Long Press", Toast.LENGTH_SHORT).show();
            Log.d("Long Press", "VOLUME DOWN LONG PRESS DETECTED!");
            toFlutterChannel.invokeMethod("onVolumeUpLongPress", null);
        }
        return super.onKeyLongPress(keyCode, event);
    }

    @Override
    @Deprecated
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_VOLUME_UP && event.isLongPress()) {
            return true; // this prevents the system from executing the keydown command
        }
        return super.onKeyDown(keyCode, event);
    }

    private boolean isServiceEnabled(Context context, Class<?> accessibilityService) {
        ComponentName expectedComponentName = new ComponentName(context, accessibilityService);

        String enabledServicesSetting = Settings.Secure.getString(
                context.getContentResolver(),
                Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES);
        if (enabledServicesSetting == null) {
            return false;
        }

        TextUtils.SimpleStringSplitter colonSplitter = new TextUtils.SimpleStringSplitter(':');
        colonSplitter.setString(enabledServicesSetting);

        while (colonSplitter.hasNext()) {
            String componentNameString = colonSplitter.next();
            ComponentName enabledService = ComponentName.unflattenFromString(componentNameString);

            if (enabledService != null && enabledService.equals(expectedComponentName)) {
                return true;
            }
        }
        return false;
    }

    private void enableService() {
        Intent intent = new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS);
        startActivityForResult(intent, 0);
        intent.addCategory(Intent.CATEGORY_DEFAULT);
        startActivity(intent);
    }


    /**
     * @param ussdCode  - A ussd code, e.g. *130#, *162*6#
     * @param fullRoute - The sequence of steps or inputs, e.g. 1;4;2;5;6;844333161;1
     */
    private void executeUSSD(String ussdCode, String fullRoute, String carrierName) {
        int simSlot = 0;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (isDualSim()) {
                simSlot = getSimSlot(carrierName);
                String ussd = formatUSSDCode(ussdCode);
                MyAccessibilityService.route = null;
                MyAccessibilityService.route = stringToArrayList(fullRoute);
                Log.d("ROTA COMPLETA", MyAccessibilityService.route.toString());
                Intent intent = new Intent("android.intent.action.CALL", Uri.parse("tel:" + ussd));
                /*
                    "extra_asus_dial_use_dualsim",
                    "com.android.phone.extra.slot",
                    "slot",
                    "simslot",
                    "sim_slot",
                    "subscription",
                    "Subscription",
                    "phone",
                    "com.android.phone.DialingMode",
                    "simSlot",
                    "slot_id",
                    "simId",
                    "simnum",
                    "phone_type",
                    "slotId",
                    "slotIdx"
                 */
                intent.putExtra("com.android.phone.force.slot", true);
                intent.putExtra("Cdma_Supp", true);
                intent.putExtra("simSlot", simSlot);
                intent.putExtra("com.android.phone.extra.slot", simSlot);
                intent.putExtra("com.android.phone.extra", simSlot);
                startActivity(intent);
            }
        }else{
            String ussd = formatUSSDCode(ussdCode);
            MyAccessibilityService.route = null;
            MyAccessibilityService.route = stringToArrayList(fullRoute);
            Log.d("ROTA COMPLETA", MyAccessibilityService.route.toString());
            Intent intent = new Intent("android.intent.action.CALL", Uri.parse("tel:" + ussd));
            startActivity(intent);
        }



    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    public boolean isDualSim() {
        TelephonyManager manager = (TelephonyManager) getContext().getSystemService(Context.TELEPHONY_SERVICE);
        return manager.getPhoneCount() == 2;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    public int getSimSlot(String userCarrierName){
        int slotIndex = 0;
        SubscriptionManager subscriptionManager = (SubscriptionManager) getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE);

        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_PHONE_STATE}, 1);
        }
        List<SubscriptionInfo> subscriptionInfoList = subscriptionManager.getActiveSubscriptionInfoList();

        if(subscriptionInfoList!=null && subscriptionInfoList.size()>0){
            for (int i = 0; i < subscriptionInfoList.size(); i++) {
                SubscriptionInfo info = subscriptionInfoList.get(i);
                String carrierName = info.getCarrierName().toString();
                if(carrierName.equalsIgnoreCase(userCarrierName)){
                    slotIndex = info.getSimSlotIndex();
                    break;
                }
//                Log.d("slotIndex", String.valueOf(slotIndex));
//                Log.d("carrierName", carrierName);

            }
        }
        return slotIndex;
    }

    private static String formatUSSDCode(String rawUssd) {
        return rawUssd.replace("#", "") + ENCODED_HASH;
    }

    private ArrayList<String> stringToArrayList(String stringRoute) {
        ArrayList<String> route = new ArrayList<>();
        String[] routeArray = stringRoute.split(";");
        for (String step : routeArray) {
            if (!step.isEmpty()) {
                route.add(step);
            }
        }
        return route;
    }

}
/*
private List<PhoneAccountHandle> phoneAccountHandleList;
int item =0;// 0 for sim1 & 1 for sim2
private final static String simSlotName[] = {
    "extra_asus_dial_use_dualsim",
    "com.android.phone.extra.slot",
    "slot",
    "simslot",
    "sim_slot",
    "subscription",
    "Subscription",
    "phone",
    "com.android.phone.DialingMode",
    "simSlot",
    "slot_id",
    "simId",
    "simnum",
    "phone_type",
    "slotId",
    "slotIdx"
};


TelecomManager telecomManager = (TelecomManager)this.getSystemService(Context.TELECOM_SERVICE);
phoneAccountHandleList = telecomManager.getCallCapablePhoneAccounts();
Intent intent = new Intent(Intent.ACTION_CALL).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
intent.setData(Uri.parse("tel:" + number));
intent.putExtra("com.android.phone.force.slot", true);
intent.putExtra("Cdma_Supp", true);
if (item == 0) {//for sim1
    for (String s : simSlotName){
       intent.putExtra(s, 0); //0 or 1 according to sim.......
    }
    if (phoneAccountHandleList != null && phoneAccountHandleList.size() > 0)
    {
       intent.putExtra("android.telecom.extra.PHONE_ACCOUNT_HANDLE",
        phoneAccountHandleList.get(0));
    }
} else {//for sim2
   for (String s : simSlotName) {
       intent.putExtra(s, 1); //0 or 1 according to sim.......
    }
   if (phoneAccountHandleList != null && phoneAccountHandleList.size() > 1){
       intent.putExtra("android.telecom.extra.PHONE_ACCOUNT_HANDLE",
       phoneAccountHandleList.get(1));
   }
 }
  startActivity(intent);

 */