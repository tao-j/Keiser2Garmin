import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

using Toybox.BluetoothLowEnergy as Ble;

class KeiserBLEDataFieldView extends WatchUi.SimpleDataField {
    var dataSrc = null;

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = "Power";
    }

    function bind(src) {
        dataSrc = src;
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        // See Activity.Info in the documentation for available information.
        if (dataSrc != null) {
            return dataSrc.power;
        }
        else {
            return 0.1;
        }
    }

}