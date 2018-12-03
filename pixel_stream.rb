class PixelStream
  WIDTH  = 32
  HEIGHT = 36

  attr_reader :file, :pixels, :output

  def initialize(pixels)
    @pixels = pixels
    @output = []
  end

  def generate
    assemble_output
    # binding.pry
    output.map(&:chr).join
  end

  def assemble_output
    # generate snaking array of pixels
    WIDTH.times do |col|
      if col.even?
        # start at bottom and go up
        HEIGHT.times do |row|
          rising_row = HEIGHT - row - 1
          @output << @pixels[rising_row][col]
        end
      else
        # start at top and go down
        HEIGHT.times do |row|
          @output << @pixels[row][col]
        end
      end
    end
  end
end
