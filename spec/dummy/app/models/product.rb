class Product < ActiveRecord::Base
  include IdentityCache
  include IdentityCacheFetchers

  cache_index :handle, unique: true
  cache_index :vendor, :product_type
end
