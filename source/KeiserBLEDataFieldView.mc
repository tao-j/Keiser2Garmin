import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

using Toybox.BluetoothLowEnergy as Ble;

class KeiserBLEDataFieldView extends WatchUi.SimpleDataField {
    var dataSrc = null;

    var cadenceField = null;
    var heartRateField = null;
    var powerField = null;
    var calorieField = null;
    var durationField = null;
    var distanceField = null;

    const CADENCE_FIELD_ID = 0;
    const HEARTRATE_FIELD_ID = 1;
    const POWER_FIELD_ID = 2;
    const CALORIE_FIELD_ID = 3;
    const DURATION_FIELD_ID = 4;
    const DISTANCE_FIELD_ID = 5;

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = "Power(K)";

        cadenceField = createField(
            "Cadence^",
            CADENCE_FIELD_ID,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD,
             :units=>"RPM"}
        );
        cadenceField.setData(0);

        heartRateField = createField(
            "heartRate^",
            HEARTRATE_FIELD_ID,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD,
             :units=>"BPM"}
        );
        cadenceField.setData(0);

        powerField = createField(
            "Power^",
            POWER_FIELD_ID,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD,
             :units=>"W"}
        );
        powerField.setData(0);

        calorieField = createField(
            "Calorie^",
            CALORIE_FIELD_ID,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD,
             :units=>"kCal"}
        );
        calorieField.setData(0);

        durationField = createField(
            "Duration^",
            DURATION_FIELD_ID,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD,
             :units=>"s"}
        );
        durationField.setData(0);

        distanceField = createField(
            "Distance^",
            DISTANCE_FIELD_ID,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD,
             :units=>"mile"}
        );
        distanceField.setData(0);
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
            cadenceField.setData(dataSrc.cadence);
            heartRateField.setData(dataSrc.heartRate);
            powerField.setData(dataSrc.power);
            calorieField.setData(dataSrc.calorie);
            durationField.setData(dataSrc.duration);
            distanceField.setData(dataSrc.distance);

            return dataSrc.power;
        }
        else {
            return 0.1;
        }
    }

}