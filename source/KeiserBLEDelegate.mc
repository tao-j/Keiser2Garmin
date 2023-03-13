using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.BluetoothLowEnergy as Ble;

class KeiserBLEDelegate extends Ble.BleDelegate {
    var cadence = 0;
    var heartRate = 0;
    var power = 0;
    var calorie = 0;
    var duration = 0;
    var distance = 0;
    var gear = 0;

    function initialize() {
        BleDelegate.initialize();
        // System.println("init ble delegate");
    }

    function onScanResults(scanResults) {
        var bid = 4; // bike id TODO: make it a setting
        while (true) {
            var res = scanResults.next() as Ble.ScanResult;
            if (res != null) {
                if (res.getDeviceName() == null || 
                    !res.getDeviceName().equals("M3")) {
                    continue;
                }
                var msd = res.getManufacturerSpecificData(01 << 8 + 02);
                if (msd == null) {
                    continue;
                }
                if (msd[3].equals(bid)) {
                    // System.println("Parsing data");
                    parseKeiserMSD(msd);
                }
            }
            else {
                break;
            }
        }
    }

    function bytesToFloat(a, b) {
        return (a + b << 8).toFloat() / 10.0;
    }

    function bytesToInt(a, b) {
        return (a + b << 8);
    }

    function parseKeiserMSD(msd as Toybox.Lang.ByteArray) {
        var data_type = msd[2];
        if (data_type == 0 || 
            (data_type >= 128 && data_type <= 227)) {
            cadence = msd[4];
            heartRate = bytesToFloat(msd[6], msd[7]);
            power = bytesToInt(msd[8], msd[9]);
            calorie = bytesToInt(msd[10], msd[11]);
            duration = msd[12] + msd[13] * 60; // TODO: prevent wrap around at 99:99
            distance = bytesToFloat(msd[14], msd[15]);
            gear = msd[16];
        }
    }
}
