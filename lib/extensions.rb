class Hash
  def evaluate(*args)
    options = {:default => nil}.merge(args.last.is_a?(Hash) ? args.pop : {})
    target = self # Initial target is self.
    while target && key = args.shift
      target = target[key]
    end

    return target if target
    return options[:default]
  end

  def clean
    each do |k, v|
      if v.is_a?(Hash)
        v.clean
      elsif v.to_s.empty?
        delete(k)
      end
    end
  end

  def symbolize_keys_recursive
    inject({}) do |options, (key, value)|
      value = value.symbolize_keys_recursive if value.instance_of? Hash
      value = value.symbolize_keys_recursive if value.instance_of? Array
      options[key.to_sym || key] = value
      options
    end
  end
end

class String
  def words
    self.split(/\s+/)
  end
end

class Array
  def symbolize_keys_recursive
    inject([]) do |options, value|
      value = value.symbolize_keys_recursive if value.instance_of? Hash
      value = value.symbolize_keys_recursive if value.instance_of? Array
      options << value
      options
    end
  end
end

class Symbol
  def <=>(other)
    return to_s <=> other.to_s
  end
end

class NilClass
  def <=>(other)
    return to_s <=> other.to_s
  end
end

class Object
  def to_js_time
    self.to_time.to_i
  end

  def try(*args)
    options = {:default => nil}.merge(args.last.is_a?(Hash) ? args.pop : {})
    target = self # Initial target is self.
    while target && mtd = args.shift
      target = target.send(mtd) if target.respond_to?(mtd)
    end

    return target if target
    return options[:default].call if options[:default].respond_to? :call
    return options[:default]
  end
end
