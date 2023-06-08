package mz.co.ativaja.ativa_ja;

import android.accessibilityservice.AccessibilityService;
import android.accessibilityservice.AccessibilityServiceInfo;
import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.EditText;

import androidx.annotation.RequiresApi;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;

public class MyAccessibilityService extends AccessibilityService {
    public static ArrayList<String> route;
    private static final ArrayList<EditText> editTexts = new ArrayList<>();
    private static AccessibilityNodeInfo SEND_BUTTON;
    private static AccessibilityNodeInfo CANCEL_BUTTON;
    private static AccessibilityNodeInfo OK_BUTTON;
    private static AccessibilityNodeInfo TEXT_FIELD;
    private static String[] MENU_OPTIONS;

    private static AccessibilityNodeInfo getSendButton(AccessibilityEvent event) {
        List<AccessibilityNodeInfo> matches = new ArrayList<>();
        if (event.getSource() != null) {
            matches = event.getSource().findAccessibilityNodeInfosByText("Enviar");
        }
        if (matches.size() > 0) {
            return matches.get(0);
        } else {
            return null;
        }
    }

    private static AccessibilityNodeInfo getTextField(AccessibilityEvent event) {
        if (event.getSource() != null && event.getClassName() != null) {
            if (event.getClassName().toString().toLowerCase().contains("edittext")) {
                return event.getSource();
            } else {
                return null;
            }
        }
        return null;
    }

    private static AccessibilityNodeInfo getCancelButton(AccessibilityEvent event) {
        List<AccessibilityNodeInfo> matches = new ArrayList<>();
        if (event.getSource() != null) {
            matches = event.getSource().findAccessibilityNodeInfosByText("Cancelar");
        }
        if (matches.size() > 0) {
            return matches.get(0);
        } else {
            return null;
        }
    }

    private static String[] getMenuOptions(AccessibilityEvent event) {
        List<AccessibilityNodeInfo> matches = new ArrayList<>();
        if (event.getSource() != null) {
            matches = event.getSource().findAccessibilityNodeInfosByText(".");
            matches = matches.isEmpty() ? event.getSource().findAccessibilityNodeInfosByText(",") : matches;
            matches = matches.isEmpty() ? event.getSource().findAccessibilityNodeInfosByText(":") : matches;
        }
        if (event.getSource() != null && matches.size() > 0) {
            return matches.get(0).getText().toString().split("\n");
        } else {
            return null;
        }
    }

    private static String getTextFromANI(List<AccessibilityNodeInfo> anis) {
        StringBuilder text = new StringBuilder("[");
        for (AccessibilityNodeInfo ani : anis) {
            text.append("(").append(ani.getText()).append(", ").append(ani.getClassName()).append("), ");
        }
        text.append("]");
        return text.toString();
    }

    protected static void clickOnButton(AccessibilityEvent event, int index) {
        int count = -1;
        for (AccessibilityNodeInfo leaf : getLeaves(event)) {
            if (leaf.getClassName().toString().toLowerCase().contains("button")) {
                count++;
                if (count == index) {
                    leaf.performAction(AccessibilityNodeInfo.ACTION_CLICK);
                    Log.d("clickOnButton", "AccessibilityNodeInfo.ACTION_CLICK: " + leaf.getText());
                }
            }
        }
    }

    private static List<AccessibilityNodeInfo> getLeaves(AccessibilityEvent event) {
        List<AccessibilityNodeInfo> leaves = new ArrayList<>();
        if (event.getSource() != null) {
            getLeaves(leaves, event.getSource());
        }

        return leaves;
    }

    private static void getLeaves(List<AccessibilityNodeInfo> leaves, AccessibilityNodeInfo node) {
        if (node.getChildCount() == 0) {
            leaves.add(node);
            return;
        }

        for (int i = 0; i < node.getChildCount(); i++) {
            getLeaves(leaves, node.getChild(i));
        }
    }

    protected static boolean isInputText(AccessibilityEvent event) {
        boolean flag = false;
        for (AccessibilityNodeInfo leaf : getLeaves(event)) {
            if (leaf.getClassName().equals("android.widget.EditText"))
                flag = true;
        }
        return flag;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        Log.d("M.A.S", "Service Connected");
    }

    @Override
    protected void onServiceConnected() {
        super.onServiceConnected();
        Log.d("Accessibility Service", "Service Connected");
        AccessibilityServiceInfo info = new AccessibilityServiceInfo();
        info.eventTypes = AccessibilityEvent.TYPES_ALL_MASK;
        info.feedbackType = AccessibilityServiceInfo.FEEDBACK_ALL_MASK;
        info.notificationTimeout = 100;
        info.packageNames = null;
        setServiceInfo(info);
        // todo: Show message to user
    }

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        if (event.getSource() != null) {

//            Log.d("getClassName()", String.valueOf(event.getClassName()));
//            Log.d("getText()", event.getSource() != null ? String.valueOf(event.getSource().getText()) : "getSource Is Null");
//            Log.d("isClickable()", event.getSource() != null ? String.valueOf(event.getSource().isClickable()): "getSource Is Null 2");

            AccessibilityEvent auxEvent = event;

            if (MENU_OPTIONS == null && getMenuOptions(event) != null) {
                MENU_OPTIONS = getMenuOptions(event);
            }
            if (SEND_BUTTON == null && getSendButton(event) != null) {
                SEND_BUTTON = getSendButton(event);
            }
            if (TEXT_FIELD == null && getTextField(event) != null) {
                TEXT_FIELD = getTextField(event);
            }

            if (MENU_OPTIONS != null && SEND_BUTTON != null && TEXT_FIELD != null && route.size() > 0) {
//                Log.d("SEND-BUTTON", SEND_BUTTON.toString()); //todo: Uncomment
                Log.d("MENU-OPTIONS", Arrays.toString(MENU_OPTIONS)); //todo: Uncomment
//                 Log.d("TEXT-FIELD", TEXT_FIELD.toString()); //todo: Uncomment

                Bundle arguments = new Bundle();
                if (!route.isEmpty()) {
                    arguments.putCharSequence(AccessibilityNodeInfo.ACTION_ARGUMENT_SET_TEXT_CHARSEQUENCE,
                            route.get(0));
                    TEXT_FIELD.performAction(AccessibilityNodeInfo.ACTION_SET_TEXT, arguments);
                }

                SEND_BUTTON.performAction(AccessibilityNodeInfo.ACTION_CLICK);

                Log.d("SELECTED-OPTION", route.get(0));
                route.remove(0);
                MENU_OPTIONS = null;
                SEND_BUTTON = null;
                TEXT_FIELD = null;
                Log.d("ROUTE", route.toString());

            } else if (route != null && route.isEmpty()) {

            }

            Log.d("___", "________________________________________________");
        }
    }

    @Override
    public void onDestroy() {
        route = null;
        SEND_BUTTON = null;
        CANCEL_BUTTON = null;
        OK_BUTTON = null;
        TEXT_FIELD = null;
        MENU_OPTIONS = null;
        super.onDestroy();
        Log.d("M.A.S", "onDestroy() - Service Disconnected");
    }

    @Override
    public void onInterrupt() {
        route = null;
        SEND_BUTTON = null;
        CANCEL_BUTTON = null;
        OK_BUTTON = null;
        TEXT_FIELD = null;
        MENU_OPTIONS = null;
        super.onDestroy();
        Log.d("M.A.S", "onInterrupt");
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private boolean isDualSim() {
        TelephonyManager manager = (TelephonyManager) getApplicationContext()
                .getSystemService(Context.TELEPHONY_SERVICE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            return manager.getPhoneCount() > 1;
        } else {
            return false;
        }
    }

    private boolean isUSSDWidget(AccessibilityEvent event) {
        return (event.getClassName().equals("amigo.app.AmigoAlertDialog")
                || event.getClassName().equals("android.app.AlertDialog")
                || event.getClassName().equals("com.android.phone.USSDDialogActivity")
                || event.getClassName().equals("com.android.phone.oppo.settings.LocalAlertDialog")
                || event.getClassName().equals("com.zte.mifavor.widget.AlertDialog")
                || event.getClassName().equals("color.support.v7.app.AlertDialog")
                || event.getClassName().equals("com.transsion.widgetslib.dialog.PromptDialog")
                || event.getClassName().equals("miuix.appcompat.app.AlertDialog"));
    }

    public AccessibilityNodeInfo getSIMOptions(AccessibilityEvent event) {
        List<AccessibilityNodeInfo> matches = new ArrayList<>();
        if (event.getSource() != null) {
            matches = event.getSource().findAccessibilityNodeInfosByText("Vodacom");
        }
        if (matches.size() > 0) {
            return matches.get(0);
        } else {
            return null;
        }
    }

    public static void cleanVaribles(){
        route = null;
        MENU_OPTIONS = null;
        SEND_BUTTON = null;
        TEXT_FIELD = null;
    }
}
