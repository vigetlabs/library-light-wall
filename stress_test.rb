require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'awesome_print'
  gem 'serialport'
  gem 'pry'
end

load "pixel_stream.rb"
load "my_color.rb"
load "serial_outputter.rb"

pixels = []

PixelStream::HEIGHT.times do |h|
  row = []

  PixelStream::WIDTH.times do |w|
    row << MyColor.to_index_from_color_name(:white)
  end

  pixels << row
end

colors = [
  :red,
  :orange,
  :yellow,
  :green,
  :indigo,
  :blue,
  :violet,
  :white
]
currentColor = 0

while true do
  PixelStream::HEIGHT.times do |h|
    PixelStream::WIDTH.times do |w|
      pixels[h][w] = MyColor.to_index_from_color_name(colors[currentColor])

      stream = PixelStream.new(pixels).generate
      SerialOutputter.output(stream)
    end
  end

  currentColor += 1
  currentColor = currentColor % colors.length
end
