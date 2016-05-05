#if arch(arm) && os(Linux)
    import Glibc
#else
    import Darwin
#endif

if let motor1 = SBPWM(header: .P8, pin: 13) {
	motor1.setValue(0)
	motor1.setEnable(true)
	for index in 10000.stride(to: 0, by: -1000) {
		print(index)
		motor1.setEnable(false)
		motor1.setValue(index)
		motor1.setEnable(true)
		usleep(5000000)
	}
	motor1.setEnable(false)
} else {
	print("Error init")
}

