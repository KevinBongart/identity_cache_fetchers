module IdentityCacheFetchers
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def fetch_or_initialize_by(attributes)
      attributes_to_fetch_by_method(attributes) || new(attributes)
    end

    def fetch_or_create_by(attributes)
      attributes_to_fetch_by_method(attributes) || create(attributes)
    end

    private

    def attributes_to_fetch_by_method(attributes)
      method_name = "fetch_by_#{attributes.keys.join('_and_')}"
      results = send(method_name, *attributes.values)

      results.is_a?(Array) ? results.first : results
    end
  end
end
