require "time"
require "test/unit"

# Class to represent a class block
class Class
  attr_accessor :course, :start_time, :end_time, :days

  def initialize(course, start_time, end_time, days)
    @course = course
    @start_time = Time.parse(start_time)
    @end_time = Time.parse(end_time)
    @days = days.split(",")  # Days given as 'MW', 'TTh', etc.
  end
end

class TestBlocks < Test::Unit::TestCase
  def setup
    # Creating objects for all classes
    @engr_102_535 = Class.new("ENGR-102-535", "1:30 PM", "3:20 PM", "MW")
    @engr_102_559 = Class.new("ENGR-102-559", "10:30 AM", "12:20 PM", "MW")
    @clen_181_1 = Class.new("CLEN-181-1", "12:30 PM", "1:20 PM", "M")
    @clen_181_2 = Class.new("CLEN-181-2", "12:00 PM", "12:50 PM", "T")
    @clen_181_6 = Class.new("CLEN-181-6", "12:00 PM", "12:50 PM", "Th")
    @math_2412_029 = Class.new("MATH-2412-029", "1:30 PM", "3:15 PM", "TTh")
    @chem_1309_001 = Class.new("CHEM-1309-001", "9:00 AM", "10:20 AM", "MW")
    @chem_1109_005 = Class.new("CHEM-1109-005", "10:30 AM", "1:20 PM", "M")

    # Create blocks by combining class objects
    @blocks = [
      # Block 1 - Yellow
      [@engr_102_535, @clen_181_2, @math_2412_029, @chem_1309_001, @chem_1109_005],


      # Block 2 - Orange1
      [@engr_102_535, @clen_181_2, @math_2412_029, @chem_1309_001, @chem_1109_005]
    ]
  end

  # Test for Block 1
  def test_block_1
    block = @blocks[0]  # Block 1 - Yellow

    assert_equal "ENGR-102-535", block[0].course
    assert_equal Time.parse("1:30 PM"), block[0].start_time
    assert_equal Time.parse("3:20 PM"), block[0].end_time
    assert_equal ["MW"], block[0].days

    assert_equal "CLEN-181-2", block[1].course
    assert_equal Time.parse("12:00 PM"), block[1].start_time
    assert_equal Time.parse("12:50 PM"), block[1].end_time
    assert_equal ["T"], block[1].days
  end

  # Test for Block 2
  def test_block_2
    block = @blocks[1]  # Block 2 - Orange1

    assert_equal "ENGR-102-535", block[0].course
    assert_equal Time.parse("1:30 PM"), block[0].start_time
    assert_equal Time.parse("3:20 PM"), block[0].end_time
    assert_equal ["MW"], block[0].days

    assert_equal "CLEN-181-2", block[1].course
    assert_equal Time.parse("12:00 PM"), block[1].start_time
    assert_equal Time.parse("12:50 PM"), block[1].end_time
    assert_equal ["T"], block[1].days
  end
end
