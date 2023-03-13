import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.BluetoothLowEnergy as Ble;

class KeiserBLEDataFieldApp extends Application.AppBase {
    var BleDataSrc = null;

    function initialize() {
        AppBase.initialize();
        BleDataSrc = new KeiserBLEDelegate();
        Ble.setDelegate(BleDataSrc);
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        Ble.setScanState(Ble.SCAN_STATE_SCANNING);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        Ble.setScanState(Ble.SCAN_STATE_OFF);
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var view = new KeiserBLEDataFieldView();
        view.bind(BleDataSrc);
        return [ view ] as Array<Views or InputDelegates>;
    }

}

function getApp() as KeiserBLEDataFieldApp {
    return Application.getApp() as KeiserBLEDataFieldApp;
}
