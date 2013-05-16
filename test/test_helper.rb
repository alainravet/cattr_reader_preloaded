require "minitest/autorun"
require File.dirname(__FILE__) + '/../lib/cattr_reader_preloaded'

def load_file(fixture)
  load File.dirname(__FILE__) + "/../test/fixtures/#{fixture}"
end

def assert_slower_than(minimum_time)
  start = Time.now
  yield
  time_taken = (Time.now - start)
  assert minimum_time < time_taken, "test was too fast (#{time_taken}); it should have take more than #{minimum_time}"
end

def assert_faster_than(maximum_time)
  start = Time.now
  yield
  time_taken = (Time.now - start)
  assert time_taken < maximum_time, "test was too slow (#{time_taken}); it should have take less than #{maximum_time}"
end
