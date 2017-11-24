module CustomError
  def custom_error(sym)
    klass = Object.const_set(sym.to_s.titleize.sub(/ /,''), Class.new(StandardError))
    klass
  end
end