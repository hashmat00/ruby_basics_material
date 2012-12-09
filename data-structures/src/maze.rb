class Maze
  def self.read_maze(maze_str)
    maze_map = {}
    start_pos = nil

    maze_str.lines.each_with_index do |row, i|
      row.split("").each_with_index do |char, j|
      end
    end

    Maze.new(maze_map, start_pos)
  end

  def initialize(dim, maze_map, start_pos)
    @width, @height = dim
    @maze_map, @current_pos = [maze_map, start_pos]
  end

  def move(direction)
    case direction
    when :up
      m(0, 1)
    when :right
      m(1, 0)
    when :down
      m(0, -1)
    when :left
      m(-1, 0)
    else
      raise ArgumentError.new("Bad direction")
    end
  end

  private
  def add_pos
    case char
    when "S"
      raise "Two start positions" if start_pos

      start_pos = [i, j]
      maze_map[[i, j]] = :open
    when "W"
      maze_map[[i, j]] = :closed
    when "E"
      maze_map[[i, j]] = :goal
    else
      raise ArgumentError.new("Invalid map character!")
    end
  end

  def m(dx, dy)
    next_pos = [@current_position[0] + dx, @current_position[1] + dy]

    if within_bounds?(next_pos)
      @current_position = next_pos
      true
    else
      false
    end
  end

  def within_bounds?(pos)
      (0...@width).include?(pos[0]) and (0...@height).include?(pos[1])
  end
end
