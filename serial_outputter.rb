class SerialOutputter
  class << self
    # PORT_STR  = '/dev/ttyACM0'
    PORT_STR  = '/dev/tty.usbmodem1411'
    BAUD_RATE = 115200
    DATA_BITS = 8
    STOP_BITS = 1
    PARITY    = SerialPort::NONE

    def output(stream)
      serial_port.write("viget" + stream)
    end

    def serial_port
      serial_port ||= SerialPort.new(PORT_STR, BAUD_RATE, DATA_BITS, STOP_BITS, PARITY)
    end
  end
end
