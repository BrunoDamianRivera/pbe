require "gtk3"
require '/home/brunorivera/Desktop/gtkruby/puzzle2/final'

app = Gtk::Application.new("org.gtk.example", :flags_none)

app.signal_connect "activate" do |application|

  display = I2C::Drivers::LCD::Display.new('/dev/i2c-1', 0x27, rows=20, cols=4)
  Lcd = Lcd.new(display)

  window = Gtk::ApplicationWindow.new(application)
  window.set_title("Lcd")
  window.set_default_size(160, 120)
  
  grid = Gtk::Grid.new
  window.add(grid)
  
  scrolledwindow = Gtk::ScrolledWindow.new
  scrolledwindow.set_hexpand(true)
  scrolledwindow.set_vexpand(true)
  
  view = Gtk::TextView.new
  scrolledwindow.add(view)
  
  grid.attach(scrolledwindow,0,0,1,1)
  
  button = Gtk::Button.new(:label => "Display")
  button.signal_connect("clicked"){ 
  puts view.buffer.text 
  Lcd.read_uid(view.buffer.text)
  }
  grid.attach(button,0,1,1,2)
  
  window.show_all
  

end

puts app.run
