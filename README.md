# Garmin Keiser M Series BLE 

This implements a [Garmin Connect IQ software](https://developer.garmin.com/connect-iq/) to capture Keiser M series bikes Bluetooth LE data according to their published [specs](https://dev.keiser.com/mseries/direct/).

Since Keiser only broadcasts the data ([GAP](https://learn.adafruit.com/introduction-to-bluetooth-low-energy/gap)), so no connection logic (GATT) is required. The program simply scans/receives and read the device with name "M3".

Only power values are shown as a Data Field. However, all other data such as cadence, distance, duration are also captured and recorded in [FIT](https://developer.garmin.com/fit/protocol/). Best effort has been made to align those fields (`nativeNum`) with the record number defined in `protocol.xlsx` from the [FIT SDK](`https://developer.garmin.com/fit/download/`).

When uploading the resulting data into [Strava](https://strava.com), cadence is not recognized somehow. One can convert FIT into TCX to fix this. Also, there is no hope by using connect IQ to override native Garmin cadence/power/distance values. One may want to use a BLE to ANT+ converter if such thing is desired. I only know that nrf52840 can be a good starting point, but this is going to be a huge undertake.