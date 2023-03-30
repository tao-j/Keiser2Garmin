# Garmin Keiser M Series BLE 
**This only records and displays data. It will not be analyzed by Garmin Connect (ex. distance, duration, effort and many more) due to limitations imposed by the vendor.**

The way makes Garmin Connect to analyze the data: [Keiser2ANT](https://github.com/tao-j/Keiser2ANT)

## Usage Tips
Install: [Garmin Connect IQ Store Link](https://apps.garmin.com/en-US/apps/3ff8a2fc-dc5d-4509-a7d8-33d7f7d43a45)

Change the `bike ID`: a `Settings` button can be clicked in the Connect IQ Store app on the phone (iOS or Android) after installation. It has to be set before opening any workout referencing this data field.

Monitor the if the data is captured.

After workout, full FIT data is can be downloaded from [Garmin Connect](https://connect.garmin.com) (CIQ).

Try the offical mSeries app from Keiser to see if BLE data can be received by phone if the data is not shown on watch.

## Technical Details
This implements a [Garmin Connect IQ software](https://developer.garmin.com/connect-iq/) to capture Keiser M series bikes Bluetooth LE (Bluetooth Smart, BLE) data according to their published [specs](https://dev.keiser.com/mseries/direct/).

Since Keiser only broadcasts the data ([GAP](https://learn.adafruit.com/introduction-to-bluetooth-low-energy/gap)), so no connection logic (GATT) is required. The program simply scans/receives and read the device with name "M3".

Only power values are shown as a Data Field. However, all other data such as cadence, distance, duration are also captured and recorded in [FIT](https://developer.garmin.com/fit/protocol/).

## About How to Use and Display the Data
Best effort has been made to align those fields (`nativeNum`) with the record number defined in `protocol.xlsx` from the [FIT SDK](`https://developer.garmin.com/fit/download/`). However, CIQ web service does not honor this information since it is user supplied. This is because when using the SDK to record the data, they are put into `customDefined` data structure in the FIT file, and the `nativeNum` is just annotation only, which is disregarded by the Garmin. This behavior is reflected both in their SDK document and the unresponsiveness when users requested this feature in their forum.

When uploading the resulting data into [Strava](https://strava.com), only power field is analyzed. One can convert FIT into TCX or write them into FIT by using `Global Profile` definition to fix this. 

There is no hope by using connect IQ to override native Garmin cadence/power/distance values. One may want to use a BLE to ANT+ converter and use [Keiser2ANT](https://github.com/tao-j/Keiser2ANT) if such thing is desired. 

For a complete portable solution, I only know that NRF52840 can be a good starting point, but this is going to be a huge undertake to set up the SDK especially the `soft-device`. NRF24AP1 is hard to find these days, otherwise simple serial programming on ESP32 would suffice.
