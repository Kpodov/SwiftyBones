#if arch(arm) && os(Linux)
    import Glibc
#else
    import Darwin
#endif

var AnalogPins:[String: BBExpansionPin] = [
    "AIN0": (header:.P9, pin:39),
    "AIN1": (header:.P9, pin:40),
    "AIN2": (header:.P9, pin:37),
    "AIN3": (header:.P9, pin:38),
    "AIN4": (header:.P9, pin:33),
    "AIN5": (header:.P9, pin:36),
    "AIN6": (header:.P9, pin:35)
]

struct SBAnalog: GPIO {
    
    private static let ANALOG_BASE_PATH = "/sys/bus/iio/devices/iio:device0/"
    private static let ANALOG_VALUE_FILE_START = "/in_voltage"
    private static let ANALOG_VALUE_FILE_END = "_raw"
    private var header: BBExpansionHeader
    private var pin: Int
    private var id: String
    
    init?(id: String) {
        if let val = AnalogPins[id] {
            self.id = id
            self.header = val.header
            self.pin = val.pin
            if !isPinActive() {
                initPin()
            }

        } else {
            return nil
        }
    }
    
    init?(header: BBExpansionHeader, pin: Int) {
        for (key, expansionPin) in AnalogPins where expansionPin.header == header && expansionPin.pin == pin {
            self.header = header
            self.pin = pin
            self.id = key
            if !isPinActive() {
                initPin()
            }
            return
        }
        return nil
        
    }
    
    func initPin() {
        writeStringToFile("BB-ADC", path: "/sys/devices/platform/bone_capemgr/slots")
        usleep(1000000)
    }
    
    func isPinActive() -> Bool {
        if let _ = readStringFromFile(getValuePath()) {
            return true
        } else {
            return false
        }
    }
    
    func getValue() -> Double? {
        if let value = readStringFromFile(getValuePath()), doubleValue = Double(value) {
            return doubleValue
        }
        return nil
    }
    
    private func getValuePath() -> String {
        return SBAnalog.ANALOG_BASE_PATH + SBAnalog.ANALOG_VALUE_FILE_START + getPinNumber() + SBAnalog.ANALOG_VALUE_FILE_END
    }
    
    private func getPinNumber() -> String {
        let range = id.startIndex.advancedBy(3)..<id.endIndex.advancedBy(0)
        return id[range]
    }
    
}

