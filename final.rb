require 'i2c/drivers/lcd'

class Rfid

  def initialize(display)
    # atributos
    @display = display

  end

  def read_uid(texto)

    def interval seconds
      loop do
        yield
        sleep seconds
        break
      end
    end

    @display.clear
    vector = texto.chars
    puts texto.length.to_s
    i=0
    j=0

      v = ""
    vector.each do |element|
      i+=1
      interval 0.1 do
      v += element
      print v
      @display.text(v,j)
      #
      if i>17 && element == " "
        i == 20
      end
      #
    end
        if i==20
          i=0
          j+=1
          v = ""
        end
        if j==4
          j=0
          @display.clear
        end
        puts i.to_s + " " + j.to_s
    end

  end

end

#inicia el main

if __FILE__ == $0

  display = I2C::Drivers::LCD::Display.new('/dev/i2c-1', 0x27, rows=20, cols=4)
  rf = Rfid.new(display)
  rf.read_uid("Introduce un texto")
  text = gets.chomp
  rf.read_uid(text)

end
