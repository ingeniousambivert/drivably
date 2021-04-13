from pyfirmata import Arduino, util
import time

if __name__ == "__main__":
    # PORT in MacBook Air
    board = Arduino("/dev/tty.usbmodem14201")
    print("Communication with Arduino successfully started")

    def start_accelerometer(board):
        it = util.Iterator(board)
        it.start()

        groundpin = board.get_pin("a:4:pwm")
        powerpin = board.get_pin("a:5:pwm")

        xpin = board.get_pin("a:3:i")
        ypin = board.get_pin("a:2:i")
        zpin = board.get_pin("a:1:i")

        groundpin.write(0)  # Low
        powerpin.write(1)  # High

        while True:
            print("X:{xpin} Y:{ypin} Z:{zpin}").format(
                xpin=xpin.read(), ypin=ypin.read(), zpin=zpin.read())
            time.sleep(0.1)

    start_accelerometer(board)

    # ask_accelerometer = input("Do you want to monitor your car's axis ? [Y/N]")

    # if ask_accelerometer == "Y" or ask_accelerometer == "y":
    #     print("Started monitoring accelerometer")
    #     start_accelerometer(board)
    # else:
    #     print("Stopped monitoring accelerometer")
