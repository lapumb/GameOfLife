#
#  Game of Life class
#
#  Author(s): Nandigam, BLake Lpaum, Cole Sellers
#
class GameOfLife

  # Creates getter methods for instance variables @rows and @cols
  attr_reader  :rows, :cols

	# Constructor that initializes instance variables with default values
  def initialize()
    @grid = []
    @rows = 0
    @cols = 0
  end

  # Reads data from the file, instantiates the grid, and loads the
	# grid with data from file. Sets this.grid, this.rows, and
	# this.cols instance variables for later use.
	def loadGrid(file)
		data = IO.read(file)
		tokens = data.strip.split(' ')

		@rows = tokens.shift.to_i
		@cols = tokens.shift.to_i

    #
    # TO DO: setup @grid as array of arrays and fill it with values
		# from the tokens array
		#
		@grid = Array.new (@rows)
		for i in 0...@rows
			@grid[i] = Array.new (@cols)
			@grid[i].fill{|i| tokens.shift.to_i}
		end

  end

  # Saves the current grid values to the file specified
	def saveGrid(file)
		data = @rows.to_s + ' ' + @cols.to_s

    #
    # TO DO: append the values in @grid to data
		#
		for i in 0...@rows
			for j in 0...@cols
				data += ' ' + @grid[i][j].to_s
			end
		end


		data += "\n"
		IO.write(file, data)
	end

	# Mutates the grid to next generation
	def mutate()
		# make a copy of grid and fill it with zeros
		temp = Array.new(@rows)
		for i in (0...@rows)
			temp[i] = Array.new(@cols)
			temp[i].fill(0)
		end

    #
		# TO DO: set values in temp grid to next generation
		#
		for i in 0...@rows
			for j in 0...@cols
				neighbors = getNeighbors(i, j).to_i
				if(@grid[i][j] == 1)
					if (neighbors < 2)
						#dying
						temp[i][j] = 0
					elsif (neighbors == 2 || neighbors == 3)
						#lives
						temp[i][j] = 1
					elsif (neighbors > 3)
						#dying
						temp[i][j] = 0
					end
					puts neighbors
				elsif @grid[i][j] == 0
					if (neighbors == 3)
						#lives
						temp[i][j] = 1
					end
				end
			end
		end

    # DO NOT DELETE THE CODE BELOW
		@grid = temp
	end

  # Returns the number of neighbors for cell at @grid[i][j]
	def getNeighbors(i, j)
		neighbors = 0

    #
    # TO DO: determine number of neighbors of cell at @grid[i][j]
		#
		#up/left
		if i > 0 && j > 0 && i < @rows && j < @cols
			if @grid[i-1][j-1] == 1
				neighbors += 1
			end
		end

		#up
		if i > 0 && j >= 0 && i <= @rows && j <= @cols
			if @grid[i-1][j] == 1
				neighbors += 1
			end
		end

		#up / right
		if i > 0 && j >= 0 && i < @rows && j < (@cols-1)
			if @grid[i][j+1] == 1
				neighbors += 1
			end
		end

		#left
		if i >= 0 && j > 0 && i < @rows && j < @cols
			if @grid[i][j-1] == 1
				neighbors += 1
			end
		end

		#right
		if i >= 0 && j >= 0 && i < @rows && j < (@cols-1)
			if @grid[i][j+1] == 1
				neighbors += 1
			end
		end

		#down/left
		if i >= 0 && j > 0 && i < (@rows-1) && j < @cols
			if @grid[i+1][j-1] == 1
				neighbors += 1
			end
		end

		#down
		if i >= 0 && j >= 0 && i < (@rows-1) && j < @cols
			if @grid[i+1][j] == 1
				neighbors += 1
			end
		end

		#down right
		if i >= 0 && j >= 0 && i < (@rows-1) && j < (@cols-1)
			if @grid[i+1][j+1] == 1
				neighbors += 1
			end
		end

    # DO NOT DELETE THE CODE BELOW
		neighbors
	end

  # Returns a string representation of GameOfLife object
  def to_s
    return "" if @grid.length == 0
    str = "\n"
		for i in 0...@rows
			for j in 0...@cols
				if @grid[i][j] == 0
					str += ' . '
				else
					str += ' X '
				end
			end
			str += "\n"
		end
		str
  end

end
