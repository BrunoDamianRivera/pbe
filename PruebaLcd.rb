require 'i2c/drivers/lcd'
display = I2C::Drivers::LCD::Display.new('/dev/i2c-1', 0x27, rows=20, cols=4)
display.clear
#display.text(name=gets, 0)
def interval seconds
  loop do
    yield
    sleep seconds
    break
  end
end

def textoProcesado(texto,display)

  display.clear
  vector = texto.chars
  puts texto.length.to_s
  i=0
  j=0

    v = ""
  vector.each do |element|
    i+=1
    interval 0.1 do
    v += element
#   print v
    display.text(v,j)
    end
      if i==20
        i=0
        j+=1
        v = ""
      end
      if j==4
        j=0
      end
      puts i.to_s + " " + j.to_s
  end
end
textoProcesado("Introduce un texto",display)
text = gets.chomp
textoProcesado(text,display)
