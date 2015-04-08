# IdentityCacheFetchers [![Circle CI](https://circleci.com/gh/KevinBongart/identity_cache_fetchers.svg?style=svg)](https://circleci.com/gh/KevinBongart/identity_cache_fetchers) [![Code Climate](https://codeclimate.com/github/KevinBongart/identity_cache_fetchers/badges/gpa.svg)](https://codeclimate.com/github/KevinBongart/identity_cache_fetchers)

ActiveRecord#fetch_or_initialize and ActiveRecord#fetch_or_create for [IdentityCache](https://github.com/Shopify/identity_cache)

```ruby
# based on https://github.com/Shopify/identity_cache#secondary-indexes
class Product < ActiveRecord::Base
  include IdentityCache
  include IdentityCacheFetchers

  cache_index :handle, unique: true
  cache_index :vendor, :product_type
end
```

This gem brings you the equivalent of [Ruby on Rails' `find_or_initialize` and `find_or_create`](http://guides.rubyonrails.org/active_record_querying.html#find-or-build-a-new-object) but uses IdentityCache as a first source:

```ruby
Product.fetch_or_initialize_by(handle: "test")
Product.fetch_or_initialize_by(vendor: "Acme Corporation", product_type: "A thing")
Product.fetch_or_create_by(handle: "test")
Product.fetch_or_create_by(vendor: "Acme Corporation", product_type: "A thing")
```

Time to go crazy:

```ruby
gem 'identity_cache_fetchers'
```
