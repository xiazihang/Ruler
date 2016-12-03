class Object
  def self.const_missing const
    require Rulers::Util.to_underscore(const.to_s)

    const_get(const.to_sym)
  end
end
