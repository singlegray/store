require_relative 'book'
require_relative 'film'
require_relative 'disc'
class ProductCollection
  PRODUCT_TYPES = [
    { dir: 'films', klass: Film },
    { dir: 'books', klass: Book },
    { dir: 'discs', klass: Disc },
  ].freeze

  def initialize(products = [])
    @products = products
  end

  def self.from_dir(dir_path)
    products = []

    PRODUCT_TYPES.each do |dir:, klass:|
      Dir[File.join(dir_path, dir, '*.txt')].each do |path|
        products << klass.from_file(path)
      end
    end

    new(products)
  end

  def to_a
    @products
  end

  def sort!(by:, order: :acs )
    case by
    when :title
      @products.sort_by!(&:to_s)
    when :price
      @products.sort_by!(&:price)
    when :amount
      @products.sort_by!(&:amount)
    end

    @products.reverse! if order == :desc
    self
  end
end

def [](product_index)
  @products[product_index - 1]
end

def to_s
  @products.map.with_index(1) do |product, index|
    "#{index}. #{product}"
  end.join("\n")
end

def remove_out_of_stock!
  @products.select! { |product| product.amount > 0 }
end
