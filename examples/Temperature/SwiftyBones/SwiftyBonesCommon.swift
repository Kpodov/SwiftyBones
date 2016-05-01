#if arch(arm) && os(Linux)
    import Glibc
#else
    import Darwin
#endif

enum BBExpansionHeader {
    case P8
    case P9
}

typealias BBExpansionPin = (header: BBExpansionHeader, pin: Int)

protocol GPIO {
    func initPin()
    func isPinActive() -> Bool
}

extension GPIO {
    
    func bytesFromString(string: String) -> [UInt8] {
        return Array(string.utf8)
    }
    
    func stringFromBytes(bytes: UnsafeMutablePointer<UInt8>, count: Int) -> String {
        var retString = ""
        for index in 0..<count {
            if bytes[index] > 47 && bytes[index] < 58 {
                retString += String(Character(UnicodeScalar(bytes[index])))
            }
        }
        return retString
    }
    
    func readStringFromFile(path: String) -> String? {
        let fp = fopen(path, "r")
        guard fp != nil else {
            return nil
        }
        var oString = ""
        let bufSize = 8
        let buffer: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer.alloc(bufSize)
        defer {
            fclose(fp)
            buffer.dealloc(bufSize)
        }
        
        repeat {
            let count: Int = fread(buffer, 1, bufSize, fp)
            guard ferror(fp) == 0 else {
                break
            }
            if count > 0 {
                oString += stringFromBytes(buffer, count: count)
            }
        } while feof(fp) == 0
        return oString
    }
    
    func writeStringToFile(stringToWrite: String, path: String) -> Bool {
        let fp = fopen(path, "w")
        defer {
            fclose(fp)
        }
        
        let bytes = bytesFromString(stringToWrite)
        let count = fwrite(bytes, 1, bytes.count, fp)
        return count == stringToWrite.utf8.count
    }
}

