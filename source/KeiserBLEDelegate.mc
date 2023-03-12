using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.BluetoothLowEnergy as Ble;

class KeiserBLEDelegate extends Ble.BleDelegate {
    var power = 1;

    function initialize() {
        BleDelegate.initialize();
        System.println("init ble delegate");
    }

    function onScanResults(scanResults) {
        var bid = 4; // bike id
        while (true) {
            var res = scanResults.next() as Ble.ScanResult;
            if (res != null) {
                if (res.getDeviceName() == null || 
                    !res.getDeviceName().equals("M3")) {
                    continue;
                }
                var msd = res.getManufacturerSpecificData(02 << 8 + 01);
                if (msd == null) {
                    System.println("02 01");
                    msd = res.getManufacturerSpecificData(01 << 8 + 02);
                    if (msd == null) {
                        continue;
                    }
                    System.println("01 02");
                }
                if (msd[2].equals(bid) || true) {
                    // System.println("Parsing data");
                    parseKeiserMSD(msd);
                }
            }
            else {
                break;
            }
        }
    }

    function parseKeiserMSD(msd as Toybox.Lang.ByteArray) {
        var data_type = msd[2];
        if (data_type == 0 || 
            (data_type >= 128 && data_type <= 227)) {
            power = msd[8] + msd[9] << 8;
        }
    }
}