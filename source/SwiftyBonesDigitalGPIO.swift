#if arch(arm) && os(Linux)
    import Glibc
#else
    import Darwin
#endif

var DigitalGPIOPins:[String: BBExpansionPin] = [
    "gpio38": (header:.P8, pin:3),
    "gpio39": (header:.P8, pin:4),
    "gpio34": (header:.P8, pin:5),
    "gpio35": (header:.P8, pin:6),
    "gpio66": (header:.P8, pin:7),
    "gpio67": (header:.P8, pin:8),
    "gpio69": (header:.P8, pin:9),
    "gpio68": (header:.P8, pin:10),
    "gpio45": (header:.P8, pin:11),
    "gpio44": (header:.P8, pin:12),
    "gpio23": (header:.P8, pin:13),
    "gpio26": (header:.P8, pin:14),
    "gpio47": (header:.P8, pin:15),
    "gpio46": (header:.P8, pin:16),
    "gpio27": (header:.P8, pin:17),
    "gpio65": (header:.P8, pin:18),
    "gpio22": (header:.P8, pin:19),
    "gpio63": (header:.P8, pin:20),
    "gpio62": (header:.P8, pin:21),
    "gpio37": (header:.P8, pin:22),
    "gpio36": (header:.P8, pin:23),
    "gpio33": (header:.P8, pin:24),
    "gpio32": (header:.P8, pin:25),
    "gpio61": (header:.P8, pin:26),
    "gpio86": (header:.P8, pin:27),
    "gpio88": (header:.P8, pin:28),
    "gpio87": (header:.P8, pin:29),
    "gpio89": (header:.P8, pin:30),
    "gpio10": (header:.P8, pin:31),
    "gpio11": (header:.P8, pin:32),
    "gpio9": (header:.P8, pin:33),
    "gpio81": (header:.P8, pin:34),
    "gpio8": (header:.P8, pin:35),
    "gpio80": (header:.P8, pin:36),
    "gpio78": (header:.P8, pin:37),
    "gpio79": (header:.P8, pin:38),
    "gpio76": (header:.P8, pin:39),
    "gpio77": (header:.P8, pin:40),
    "gpio74": (header:.P8, pin:41),
    "gpio75": (header:.P8, pin:42),
    "gpio72": (header:.P8, pin:43),
    "gpio73": (header:.P8, pin:44),
    "gpio70": (header:.P8, pin:45),
    "gpio71": (header:.P8, pin:46),
    "gpio30": (header:.P9, pin:11),
    "gpio60": (header:.P9, pin:12),
    "gpio31": (header:.P9, pin:13),
    "gpio50": (header:.P9, pin:14),
    "gpio48": (header:.P9, pin:15),
    "gpio51": (header:.P9, pin:16),
    "gpio5": (header:.P9, pin:17),
    "gpio4": (header:.P9, pin:18),
    "gpio3": (header:.P9, pin:21),
    "gpio2": (header:.P9, pin:22),
    "gpio49": (header:.P9, pin:23),
    "gpio15": (header:.P9, pin:24),
    "gpio117": (header:.P9, pin:25),
    "gpio14": (header:.P9, pin:26),
    "gpio115": (header:.P9, pin:27),
    "gpio113": (header:.P9, pin:28),
    "gpio111": (header:.P9, pin:29),
    "gpio112": (header:.P9, pin:30),
    "gpio110": (header:.P9, pin:31),
    "gpio20": (header:.P9, pin:41),
    "gpio7": (header:.P9, pin:42)
]

enum DigitalGPIODirection: String {
    case IN="in"
    case OUT="out"
}

enum DigitalGPIOValue: String {
    case HIGH="1"
    case LOW="0"
}

struct SBDigitalGPIO: GPIO {
    
    private static let GPIO_BASE_PATH = "/sys/class/gpio/"
    private static let GPIO_EXPORT_PATH = GPIO_BASE_PATH + "export"
    private static let GPIO_DIRECTION_FILE = "/direction"
    private static let GPIO_VALUE_FILE = "/value"
    private var header: BBExpansionHeader
    private var pin: Int
    private var id: String
    private var direction: DigitalGPIODirection
    
    init?(id: String, direction: DigitalGPIODirection) {
        if let val = DigitalGPIOPins[id] {
            self.id = id
            self.header = val.header
            self.pin = val.pin
            self.direction = direction
            initPin()
        } else {
            return nil
        }
    }
    
    init?(header: BBExpansionHeader, pin: Int, direction: DigitalGPIODirection) {
        for (key, expansionPin) in DigitalGPIOPins where expansionPin.header == header && expansionPin.pin == pin {
                self.header = header
                self.pin = pin
                self.id = key
                self.direction = direction
                initPin()
                return
        }
        return nil

    }
    
    
    func initPin() {
        let range = id.startIndex.advancedBy(4)..<id.endIndex.advancedBy(0)
        let gpioId = id[range]
        writeStringToFile(gpioId, path: SBDigitalGPIO.GPIO_EXPORT_PATH)
        writeStringToFile(direction.rawValue, path: getDirectionPath())
    }
    
    func isPinActive() -> Bool {
        if let _ = getValue() {
            return true
        } else {
            return false
        }
    }

    
    func getValue() -> DigitalGPIOValue? {
        if let valueStr = readStringFromFile(getValuePath()) {
            return valueStr == DigitalGPIOValue.HIGH.rawValue ? DigitalGPIOValue.HIGH : DigitalGPIOValue.LOW
        } else {
            return nil
        }
    }
    
    func setValue(value: DigitalGPIOValue) {
        writeStringToFile(value.rawValue, path: getValuePath())
    }
    
    private func getDirectionPath() -> String {
        return SBDigitalGPIO.GPIO_BASE_PATH + id + SBDigitalGPIO.GPIO_DIRECTION_FILE
    }
    
    private func getValuePath() -> String {
        return SBDigitalGPIO.GPIO_BASE_PATH + id + SBDigitalGPIO.GPIO_VALUE_FILE
    }
}

