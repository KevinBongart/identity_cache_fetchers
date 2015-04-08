require "rails_helper"

describe IdentityCacheFetchers do
  describe ".fetch_or_initialize_by" do
    let!(:product) { Product.create(handle: "test", product_type: "A thing", vendor: "Acme Corporation") }

    it "fetches cached objects" do
      expect(Product).not_to receive(:new)

      expect(Product.fetch_by_handle("test")).to eq product
      expect(Product.fetch_or_initialize_by(handle: "test")).to eq product
    end

    it "fetches cached objects on secondary indexes" do
      expect(Product).not_to receive(:new)

      expect(Product.fetch_by_vendor_and_product_type("Acme Corporation", "A thing")).to eq [product]
      expect(Product.fetch_or_initialize_by(vendor: "Acme Corporation", product_type: "A thing")).to eq product
    end

    it "initializes new objects on cache miss" do
      expect(Product.fetch_by_handle("missing")).to be_nil

      new_product = Product.fetch_or_initialize_by(handle: "missing")

      expect(new_product).not_to be_persisted
      expect(new_product.handle).to eq "missing"
    end

    it "initializes new objects on cache miss on secondary indexes" do
      expect(Product.fetch_by_vendor_and_product_type("Acme Corporation", "A new thing")).to be_empty

      new_product = Product.fetch_or_initialize_by(vendor: "Acme Corporation", product_type: "A new thing")

      expect(new_product).not_to be_persisted
      expect(new_product.vendor).to eq "Acme Corporation"
      expect(new_product.product_type).to eq "A new thing"
    end
  end

  describe ".fetch_or_create_by" do
    let!(:product) { Product.create(handle: "test", product_type: "A thing", vendor: "Acme Corporation") }

    it "fetches cached objects" do
      expect(Product).not_to receive(:new)

      expect(Product.fetch_by_handle("test")).to eq product
      expect(Product.fetch_or_create_by(handle: "test")).to eq product
    end

    it "fetches cached objects on secondary indexes" do
      expect(Product).not_to receive(:new)

      expect(Product.fetch_by_vendor_and_product_type("Acme Corporation", "A thing")).to eq [product]
      expect(Product.fetch_or_create_by(vendor: "Acme Corporation", product_type: "A thing")).to eq product
    end

    it "creates new objects on cache miss" do
      expect(Product.fetch_by_handle("missing")).to be_nil

      new_product = Product.fetch_or_create_by(handle: "missing")

      expect(new_product).to be_persisted
      expect(new_product.handle).to eq "missing"
    end

    it "creates new objects on cache miss on secondary indexes" do
      expect(Product.fetch_by_vendor_and_product_type("Acme Corporation", "A new thing")).to be_empty

      new_product = Product.fetch_or_create_by(vendor: "Acme Corporation", product_type: "A new thing")

      expect(new_product).to be_persisted
      expect(new_product.vendor).to eq "Acme Corporation"
      expect(new_product.product_type).to eq "A new thing"
    end
  end
end
