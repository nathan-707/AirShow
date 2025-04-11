//#include <BLEDevice.h>
//#include <ArduinoJson.h>
//#include <WiFi.h>
//#include <WaitTimes.h>
//#include "esp_wifi.h"  // Required for `esp_wifi_set_ps()`
//#include "esp_bt.h"    // Required for BLE coexistence
//
//bool appCustom;
//bool youCanShowWeather;
//bool appSaidShowAll;
//bool onlyShowWeather;
//bool themeParkRequestedFromApp;
//bool redrawScreen;
//bool updatedLayout;
//unsigned long sTimer;
//
//enum MasterEffect {
//  fullEff,
//  showW,
//  onlyShowW
//};
//
//
//// Enums for light modes and overall modes
//enum LightModes {
//  custom_m,
//  dualmode_m,
//  rainbowmode_m,
//  headless_m,
//  meteorshower_m,
//  colorclock_m,
//  tempclock_m,
//  firemode_m
//};
//enum Modes {
//  home,
//  teleportMode,
//  themeParkMode,
//  sleepMode
//};
//
//struct cLight {
//  int cred;
//  int cgreen;
//  int cblue;
//};
//
//Modes ModeBeforeSleep;
//
//// Settings structure
//struct Settings {
//
//  volatile bool bleEna = true;
//
//
//  volatile bool onlyShowWeather = false;
//  volatile bool showSpecCus = false;
//
//  cLight customLights[3] = {
//    { 0, 0, 255 },  // custom
//    { 0, 0, 255 },  // twWeather
//    { 0, 0, 255 },  // bwWeather
//  };
//
//  volatile int layout = 1;
//  volatile LightModes effect = custom_m;
//  volatile Modes mode = home;
//  volatile Modes pendingMode = home;  // this is what will be written to when the phone sends a request via BLE
//  volatile bool pending = false;
//  volatile bool muted = true;
//  volatile MasterEffect masterEffect = showW;
//
//  volatile int HeadFS = 10;
//  volatile int SCFS = 10;
//  volatile int SpecFS = 10;
//  volatile int FireFS = 10;
//
//
//  volatile int tempR = 0;
//  volatile int tempG = 0;
//  volatile int tempB = 0;
//
//  volatile int park = ALL_DisneyWorld;
//  volatile int tourInterval = (60 * 1 * 3000);  // 3 min.
//
//  volatile int city = 0;
//  volatile int cityFromApp = 0;
//  volatile int parkFromApp = -200;
//
//  volatile int onT = 8;       // 8 am
//  volatile int offT = 20;     // 8pm
//  volatile bool autoOff = 0;  // automatically sleep.
//
//  volatile bool semi = 1;  // semi automatic as to it dosent sleep until dark.
//  volatile float br = 1;   // all the way up
//  volatile bool aBr = 0;   // false
//
//  volatile unsigned long sTi = 0;  // sleep timer.
//  volatile bool sTon = 0;          // sleep timer on.
//
//  String serializeSettings() {
//    StaticJsonDocument<512> doc;
//    // Mode State
//    doc["layout"] = this->layout;
//    doc["effect"] = this->effect;
//    doc["mode"] = this->mode;
//    doc["pendingMode"] = this->pendingMode;
//    doc["pending"] = this->pending;
//    doc["muted"] = this->muted;
//
//    // Light State
//    doc["masterEffect"] = this->masterEffect;
//    doc["SpecFS"] = this->SpecFS;
//    doc["HeadFS"] = this->HeadFS;
//    doc["SCFS"] = this->SCFS;
//    doc["FireFS"] = this->FireFS;
//
//    doc["cR"] = this->customLights[0].cred;
//    doc["cG"] = this->customLights[0].cgreen;
//    doc["cB"] = this->customLights[0].cblue;
//
//    doc["tempR"] = this->tempR;
//    doc["tempG"] = this->tempG;
//    doc["tempB"] = this->tempB;
//
//    doc["park"] = this->park;
//    doc["telIn"] = this->tourInterval;
//    doc["city"] = this->city;
//    doc["onT"] = this->onT;
//    doc["offT"] = this->offT;
//    doc["autoOff"] = this->autoOff;
//
//    doc["semi"] = this->semi;
//    doc["br"] = this->br;
//    doc["aBr"] = this->aBr;
//    doc["sTi"] = this->sTi;
//    doc["sTon"] = this->sTon;
//    String output;
//    serializeJson(doc, output);
//    return output;
//  }
//};
//
//cLight customLights[] = {
//  { 0, 0, 255 },  // custom
//  { 0, 0, 255 },  // twWeather
//  { 0, 0, 255 },  // bwWeather
//};
//
//Settings settings;  // Global settings instance
//
//// WiFi credentials and global JSON document (if needed)
//const char* ssid = "eriksen99";
//const char* password = "DCchiro99";
//
//void refreshScreen() {
//}
//
//bool showSpecCus;
//bool allset;
//
//
//
//
//
//
//void readAndSetSettingsBeforeTellingApp() {
//}
//
//
////////////////////////////////////////////////////////////////////////////////////////////// MARK BLUETOOTH
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#define SERVICE_UUID "E56A082E-C49B-47CA-A2AB-389127B8ABE3"
//#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"
//
//#define V_CHARACTERISTIC_UUID "beb4538e-36e1-4688-b7f5-ea07361b26a8"
//
//
//BLEServer* pServer = nullptr;
//BLEService* pService = nullptr;
//BLEAdvertising* pAdvertising = nullptr;
//BLECharacteristic* pCharacteristic;
//
//BLECharacteristic* vCharacteristic;
//
//
//volatile bool clientAuthenticated = false;
//volatile int pairingCode;
//volatile bool pairing = false;
//volatile bool bluetoothPaused = false;
//volatile bool bleInitialized = false;
//
//enum CommandType {
//  updateEffect,
//  updateMode,
//  updateLayout,
//  ping
//};
//
//
//bool userConnected = false;
//
//void pauseBLE() {
//  if (bleInitialized && settings.bleEna) {
//    pService->stop();
//    pAdvertising->stop();
//    delay(1000);
//  }
//}
//void resumeBLE() {
//  if (bleInitialized && settings.bleEna) {
//    pService->start();
//    pAdvertising->start();
//  }
//}
//void sendState() {
//
//  if (bleInitialized && settings.bleEna) {
//    String stateValue = settings.serializeSettings();
//    // Serial.println(stateValue);
//    pCharacteristic->setValue(stateValue.c_str());
//    vCharacteristic->setValue(stateValue.c_str());
//
//    pCharacteristic->notify();
//    vCharacteristic->notify();
//  }
//}
//
//
//class MyServerCallbacks : public BLEServerCallbacks {
//  void onConnect(BLEServer* pServer) override {
//    Serial.println("Connected");
//    userConnected = true;
//    sendState();
//    BLEDevice::stopAdvertising();
//    pAdvertising->stop();
//  }
//
//  void onDisconnect(BLEServer* pServer) override {
//    clientAuthenticated = false;
//    userConnected = false;
//    Serial.println("Client disconnected");
//
//    if (bluetoothPaused == false) {
//      BLEDevice::startAdvertising();
//      pAdvertising->start();
//    }
//  }
//};
//
//bool testingBluetooth = true;
//
//void debug(const char* message) {
//  if (testingBluetooth) {
//    Serial.println(message);
//  }
//}
//
//enum StateUpdateType {
//  TaskState,
//  LightSettingsState,
//  TeleportState
//};
//
//
//class MyCharacteristicCallbacks : public BLECharacteristicCallbacks {
//
//  void onWrite(BLECharacteristic* pCharacteristic) override {
//    std::string inputValue = pCharacteristic->getValue();
//    DynamicJsonDocument doc(500);
//    DeserializationError error = deserializeJson(doc, inputValue);
//    if (error) {
//      Serial.print("deserializeJson() failed: ");
//      Serial.println(error.c_str());
//      return;
//    }
//
//    const char* change = doc["command"];  // "effect"
//    const int equal = 0;
//
//
//    if (change != NULL) {
//      Serial.println(change);
//
//      if (strcmp(change, "effect") == equal) {  // light effect command.
//        debug("updated light effect.");
//        settings.effect = doc["value"];
//
//        if (settings.effect == rainbowmode_m) {
//          settings.SpecFS = doc["value2"];
//        }
//
//        else if (settings.effect == headless_m) {
//          settings.HeadFS = doc["value2"];
//        }
//
//        else if (settings.effect == meteorshower_m) {
//          settings.SCFS = doc["value2"];
//        }
//
//        else if (settings.effect == firemode_m) {
//          settings.FireFS = doc["value2"];
//        }
//      }
//
//      else if (strcmp(change, "mode") == equal) {  // update mode command.
//        debug("updated mode.");
//        settings.pendingMode = doc["value"];
//
//        if (settings.pendingMode == teleportMode) {  // teleport. get the city the app wants.
//          settings.cityFromApp = doc["value2"];      // set the teleport city.
//        }
//
//        else if (settings.pendingMode == themeParkMode) {
//          themeParkRequestedFromApp = true;
//          settings.parkFromApp = doc["value2"];
//        }
//      }
//
//      else if (strcmp(change, "layout") == equal) {  // change layout command.
//        debug("updated layout.");
//        settings.layout = doc["value"];
//        updatedLayout = true;
//      }
//
//      else if (strcmp(change, "ping") == equal) {  // pinged for state update.
//        debug("ping.");
//        sendState();
//      }
//
//      else if (strcmp(change, "showSpec") == equal) {  // master effect update.
//        settings.masterEffect = doc["value"];
//        appCustom = true;
//
//        switch (settings.masterEffect) {
//          case fullEff:
//            settings.showSpecCus = false;
//            settings.onlyShowWeather = false;
//            youCanShowWeather = false;
//            appSaidShowAll = true;
//            break;
//          case showW:
//            settings.showSpecCus = true;
//            settings.onlyShowWeather = false;
//            youCanShowWeather = true;
//            appSaidShowAll = false;
//            break;
//          case onlyShowW:
//            settings.onlyShowWeather = true;
//            youCanShowWeather = true;
//            break;
//        }
//      }
//
//      else if (strcmp(change, "cset") == equal) {
//        settings.customLights[0].cred = doc["red"];
//        settings.customLights[0].cgreen = doc["green"];
//        settings.customLights[0].cblue = doc["blue"];
//      }
//
//      else if (strcmp(change, "autoOff") == equal) {  // toggled automatic sleep.
//        settings.autoOff = doc["value"];
//        Serial.println(settings.autoOff);
//
//      }
//
//      else if (strcmp(change, "onTime") == equal) {
//        settings.onT = doc["value"];
//        Serial.println(settings.onT);
//
//      }
//
//      else if (strcmp(change, "offTime") == equal) {
//        settings.offT = doc["value"];
//        Serial.println(settings.offT);
//      }
//
//      else if (strcmp(change, "semiAutoTurnOff") == equal) {
//        settings.semi = doc["value"];
//        Serial.println(settings.semi);
//      }
//
//      else if (strcmp(change, "tourInterval") == equal) {
//        settings.tourInterval = doc["value"];
//        Serial.println(settings.tourInterval);
//      }
//
//      else if (strcmp(change, "autoBrightnessOn") == equal) {
//
//        settings.aBr = doc["value"];
//
//        if (!settings.aBr) {
//          settings.br = 1;
//        }
//
//        Serial.println(settings.aBr);
//      }
//
//      else if (strcmp(change, "brightness") == equal) {
//        settings.br = doc["value"].as<float>();
//        Serial.println(settings.br);
//      }
//
//      else if (strcmp(change, "sleepTimer") == equal) {
//
//        int sleepTimerSent = doc["value"];
//
//        settings.sTi = sleepTimerSent;  // if the app sends 0, it will automatically turn sleep timer off as is.
//
//        if (sleepTimerSent > 0) {
//          sTimer = millis();
//          settings.sTon = true;
//          settings.mode = ModeBeforeSleep;
//        }
//      }
//
//
//    } else {
//      Serial.println("Command null.");
//      return;
//    }
//  }
//  void onRead(BLECharacteristic* pCharacteristic) override {}
//};
//
//class MySecurityCallbacks : public BLESecurityCallbacks {
//  uint32_t onPassKeyRequest() override {
//    uint32_t passkey = 654321;
//    Serial.print("Passkey requested by client. Enter this on your phone: ");
//    Serial.println(passkey);
//    return passkey;
//  }
//
//  void onPassKeyNotify(uint32_t pass_key) override {
//    Serial.print("Passkey notified: ");
//    Serial.println(pass_key);
//    pairingCode = pass_key;
//    pairing = true;
//  }
//
//
//  bool onConfirmPIN(uint32_t pin) override {
//    Serial.print("Confirm PIN (Numeric Comparison): ");
//    Serial.println(pin);
//    return true;  // Auto-confirm for testing
//  }
//  bool onSecurityRequest() override {
//    Serial.println("Security request received from client");
//    return true;
//  }
//
//
//  void onAuthenticationComplete(esp_ble_auth_cmpl_t auth) override {
//    pairing = false;
//    if (auth.success) {
//      clientAuthenticated = true;
//      appCustom = true;
//      Serial.println("Authentication successful");
//      sendState();
//    } else {
//      Serial.print("Authentication failed, reason: ");
//      Serial.println(auth.fail_reason);
//    }
//  }
//};
//
//// // old setup that doesnt allow just works.
//void setupBLE() {
//  // delay(2000);
//
//  if (settings.bleEna == false) {
//    return;
//  }
//
//  Serial.println("Starting BLE and Wi-Fi work!");
//  esp_bt_controller_mem_release(ESP_BT_MODE_CLASSIC_BT);
//
//  BLEDevice::init("App Control");
//  BLEDevice::setPower(ESP_PWR_LVL_N9);  // Set BLE transmission power
//  BLEDevice::setSecurityCallbacks(new MySecurityCallbacks());
//  BLEDevice::setMTU(517);  // Maximum MTU supported by ESP32 is 517 bytes
//
//  BLESecurity* pSecurity = new BLESecurity();
//  pSecurity->setAuthenticationMode(ESP_LE_AUTH_BOND);
//  pSecurity->setCapability(ESP_IO_CAP_IO);
//
//  pServer = BLEDevice::createServer();
//  pServer->setCallbacks(new MyServerCallbacks());
//  pService = pServer->createService(SERVICE_UUID);
//
//  pCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID, BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_WRITE | BLECharacteristic::PROPERTY_NOTIFY);
//  pCharacteristic->setAccessPermissions(ESP_GATT_PERM_READ_ENC_MITM | ESP_GATT_PERM_WRITE_ENC_MITM);
//  pCharacteristic->setCallbacks(new MyCharacteristicCallbacks());
//  pCharacteristic->setValue("Hello from Arduino");
//
//  vCharacteristic = pService->createCharacteristic(V_CHARACTERISTIC_UUID, BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_NOTIFY);
//  vCharacteristic->setAccessPermissions(ESP_GATT_PERM_READ);
//  vCharacteristic->setValue("V char");
//
//  pService->start();
//  pAdvertising = BLEDevice::getAdvertising();
//  pAdvertising->addServiceUUID(SERVICE_UUID);
//  pAdvertising->setScanResponse(true);
//  pAdvertising->setMinPreferred(0x06);
//  pAdvertising->setMinPreferred(0x12);
//  BLEDevice::startAdvertising();
//  bleInitialized = true;
//  delay(1000);
//}
//
//
//
/////////////////////////////////////////////////////////////////////////// MARK END BLUETOOTH
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//void setup() {
//  Serial.begin(9600);
//  // WiFi.begin(ssid, password);
//  Serial.println("Connecting");
//  int dots = 0;
//  // while (WiFi.status() != WL_CONNECTED) {
//  //   Serial.print(".");
//  //   delay(500);
//  //   if (dots >= 3) {
//  //     dots = 0;
//  //   }
//  //   dots++;
//  // }
//  // connected and setup if here.
//  setupBLE();
//}
//
//
//
//void loop() {
//}
