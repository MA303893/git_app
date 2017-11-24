module CustomError
  def custom_error(sym)
    klass = Object.const_set(sym.to_s, Class.new(StandardError))
    klass
  end
end