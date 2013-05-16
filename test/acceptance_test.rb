require File.dirname(__FILE__) + '/test_helper'

class TestCAttrReaderPreloaded < MiniTest::Unit::TestCase

  def test_call_twice_a_method_that_does_not_preload
    load_file('class_without_value_preloading.rb')

    # no preloading => each call is slow and takes about the same time
    assert_slower_than(0.1    ) { ClassWithoutValuePreloading.slow_op  }
    assert_slower_than(0.1    ) { ClassWithoutValuePreloading.slow_op  }
  end



  def test_call_twice_a_method_that_preloads
    load_file('class_with_value_preloading.rb')

    # at this point, the value preloading is still running => must wait till it's finished
    assert_slower_than(0.4    ) { @value = ClassWithValuePreloading.slow_op  }
    assert @value == '<value-returned>'

    # preloading is  finished => the second call is much faster
    assert_faster_than(0.001) { @value = ClassWithValuePreloading.slow_op  }
    assert @value == '<value-returned>'
  end



  def test_call_in_one_class_two_method_that_preload
    load_file('class_with_two_values_preloading.rb')
    # at this point, the values preloading is still running => must wait till it's finished

    assert_slower_than(0.4    ) { @value = ClassWithTwoValuesPreloading.slow_op    }
    assert @value == '<value-returned>'

    # preloading of ALL values is finished
    #  => 1st call on the 2nd method is almost instantaneous (value is already computed)
    assert_faster_than(0.001) { @value = ClassWithTwoValuesPreloading.slow_op_2  }
    assert @value == '<value_2-returned>'
  end

end
