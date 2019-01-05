class Mishmash < Hash
  def initialize(input, schema={}, output={})
    input.each_pair do |key,value|
      self[key] = value
    end
    self.translate(schema, output) unless schema.empty?
  end

  def translate(schema, output={})
    return unless self.is_a?(Hash) && schema.is_a?(Hash)
    (self.keys | schema.keys).each_with_object({}) do |k, diff|
      if self[k] && schema[k] && self[k] != schema[k]
        if self[k].is_a?(Hash) && schema[k].is_a?(Hash)
         Mishmash.new(self[k]).translate(schema[k], output)
        elsif self[k].is_a?(Array) &&  schema[k].is_a?(Array)
          output[schema[k][0]] = self[k].map do |kk,vv|
            Mishmash.new(kk).translate(schema[k][1])
          end
        elsif self[k].is_a?(Array) && schema[k].is_a?(Hash)
          self[k].each do |kk|
            if  (self[k].map(&:values).flatten & schema[k].values).empty? || !(kk.values & schema[k].values).empty?
              Mishmash.new(kk).translate(schema[k], output) 
            end
          end
        elsif output[schema[k]]
          output[schema[k]] = [output[schema[k]]] unless output[schema[k]].is_a?(Array)
          output[schema[k]].push(self[k])
         elsif self[k]
          output[schema[k]] = self[k]
        end
      end
    end
    return Mishmash.new(output)
  end
end