class ClassWithValuePreloading

  cattr_reader_preloaded :slow_op do
    sleep 0.5     # simulate a costly value precomputing
    '<value-returned>'
  end

end
