class ClassWithTwoValuesPreloading

  cattr_reader_preloaded(:slow_op  ) do
    sleep 0.5
    '<value-returned>'
  end
  cattr_reader_preloaded(:slow_op_2) do
    sleep 0.3
    '<value_2-returned>'
  end

end
