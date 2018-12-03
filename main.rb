require 'rubygems'
require 'bundler/setup'

load "pixel_stream.rb"
load "my_color.rb"
load "serial_outputter.rb"

def generate_black_canvas
  pixels = []

  PixelStream::HEIGHT.times do |h|
    row = []
    PixelStream::WIDTH.times do |w|
      row << MyColor.to_index_from_color_name(:black)
    end
    pixels << row
  end

  pixels
end

def generate_possible_pairs
  pairs = []

  PixelStream::HEIGHT.times do |h|
    PixelStream::WIDTH.times do |w|
      pairs << [h, w]
    end
  end

  pairs
end

def random_color
  randomRange = rand(100)

  case randomRange
  when 1..4
    pixelColor = :red
  when 5..7
    pixelColor = :orange
  when 8..34
    pixelColor = :yellow
  when 35..55
    pixelColor = :green
  when 56..75
    pixelColor = :indigo
  when 76..80
    pixelColor = :blue
  when 81..100
    pixelColor = :violet
  else
    pixelColor = :white
  end
end

while true do
  possible_pairs = generate_possible_pairs
  pixels = generate_black_canvas

  while possible_pairs.length > 0
    random_index = rand(possible_pairs.length)
    x, y = possible_pairs.delete_at(random_index)

    pixels[x][y] = MyColor.to_index_from_color_name(random_color)

    stream = PixelStream.new(pixels).generate
    SerialOutputter.output(stream)
  end

  sleep(15)
end
