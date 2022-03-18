/*
   Based on Neil Kolban example for IDF: https://github.com/nkolban/esp32-snippets/blob/master/cpp_utils/tests/BLE%20Tests/SampleScan.cpp
   Ported to Arduino ESP32 by pcbreflux
*/

 
/*
   Create a BLE server that will send periodic iBeacon frames.
   The design of creating the BLE server is:
   1. Create a BLE Server
   2. Create advertising data
   3. Start advertising.
   4. wait
   5. Stop advertising.
   6. deep sleep
   
*/
#include "sys/time.h"

#include "BLEDevice.h"
#include "BLEUtils.h"
#include "BLEBeacon.h"
#include "esp_sleep.h"

#define GPIO_DEEP_SLEEP_DURATION     10  // sleep x seconds and then wake up
RTC_DATA_ATTR static time_t last;        // remember last boot in RTC Memory
RTC_DATA_ATTR static uint32_t bootcount; // remember number of boots in RTC Memory

#ifdef __cplusplus
extern "C" {
#endif

uint8_t temprature_sens_read();
//uint8_t g_phyFuns;

#ifdef __cplusplus
}
#endif

// See the following for generating UUIDs:
// https://www.uuidgenerator.net/
BLEAdvertising *pAdvertising;
struct timeval now;

#define BEACON_UUID           "88fd7faa-9873-11ec-b909-0242ac120002" // Room 9901
//#define BEACON_UUID           "32bdcbab-28ae-4ad1-ad8a-122a57f4d821" // Room 9902
//#define BEACON_UUID           "ed2d88f1-c58b-4d6a-bb62-955e8478ca83" // Room 9903
//#define BEACON_UUID           "eea4b626-c2c6-49e7-953b-52d20ce2da1f" // Room 9904

void setBeacon() {

  BLEBeacon oBeacon = BLEBeacon();
  oBeacon.setManufacturerId(0x4C00); // fake Apple 0x004C LSB (ENDIAN_CHANGE_U16!)
  oBeacon.setProximityUUID(BLEUUID(BEACON_UUID));
  oBeacon.setMajor((bootcount & 0xFFFF0000) >> 16);
  oBeacon.setMinor(bootcount&0xFFFF);
  BLEAdvertisementData oAdvertisementData = BLEAdvertisementData();
  BLEAdvertisementData oScanResponseData = BLEAdvertisementData();
  
  oAdvertisementData.setFlags(0x04); // BR_EDR_NOT_SUPPORTED 0x04
  
  std::string strServiceData = "";
  
  strServiceData += (char)26;     // Len
  strServiceData += (char)0xFF;   // Type
  strServiceData += oBeacon.getData(); 
  oAdvertisementData.addData(strServiceData);
  
  pAdvertising->setAdvertisementData(oAdvertisementData);
  pAdvertising->setScanResponseData(oScanResponseData);
  pAdvertising->setAdvertisementType(ADV_TYPE_NONCONN_IND);

}

void setup() {

    
  Serial.begin(115200);
  gettimeofday(&now, NULL);

  Serial.printf("start ESP32 %d\n",bootcount++);

  Serial.printf("deep sleep (%lds since last reset, %lds since last boot)\n",now.tv_sec,now.tv_sec-last);

  last = now.tv_sec;
  
  // Create the BLE Device
  BLEDevice::init("R9901"); //Room 9901
  //BLEDevice::init("R9902"); //Room 9902
  //BLEDevice::init("R9902"); //Room 9903
  //BLEDevice::init("R9902"); //Room 9904

  // Create the BLE Server
  // BLEServer *pServer = BLEDevice::createServer(); // <-- no longer required to instantiate BLEServer, less flash and ram usage

  pAdvertising = BLEDevice::getAdvertising();
  
  setBeacon();
   // Start advertising
  pAdvertising->start();
  Serial.println("Advertizing started...");
  delay(100);
  pAdvertising->stop();
  Serial.printf("enter deep sleep\n");
  esp_deep_sleep(1000000LL * GPIO_DEEP_SLEEP_DURATION);
  Serial.printf("in deep sleep\n");
}

void loop() {
}
