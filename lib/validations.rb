#def validates_positive(*attr_names)
#  configuration = { :message => "Cannot be less than 1" }
#  configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
#  validates_each attr_names do |m, a, v| m.errors.add(a, configuration[:message]) if v<1 end
#end

#def validates_not_null(*attr_names)
#  configuration = { :message => "Cannot be nil" }
#  configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
#  validates_each attr_names do |m, a, v| m.errors.add(a, configuration[:message]) if v == nil end
#end

