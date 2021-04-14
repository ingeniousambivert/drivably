from pyfirmata import Arduino, util
import time
import redis

redisClient = redis.StrictRedis(
    host="localhost", port=6379, charset="utf-8", decode_responses=True)

status = {"key": "drowsy",
          "value": "ALERT"}


def test_led(board):
    while redisClient.get(status["key"]):
        board.digital[4].write(1)
        board.digital[3].write(1)
        print("HIGH")
        time.sleep(1)
        board.digital[4].write(0)
        board.digital[3].write(0)
        print("LOW")
        time.sleep(1)


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


if __name__ == '__main__':
    board = None

    board_type = input("Choose Mac - M | Raspberry Pi - P \n")

    if board_type == "M" or board_type == "m":
        board = Arduino("/dev/tty.usbmodem14201")

    elif board_type == "P" or board_type == "p":
        board = Arduino("/dev/ttyACM0")

    if board is not None:
        print("Communication with Arduino successfully started")

        test_led(board)

        # start_accelerometer(board)

    # ask_accelerometer = input("Do you want to monitor your car's axis ? [Y/N]")

    # if ask_accelerometer == "Y" or ask_accelerometer == "y":
    #     print("Started monitoring accelerometer")
    #     start_accelerometer(board)
    # else:
    #     print("Stopped monitoring accelerometer")

    else:
        print("Communication failed. Check connection")
