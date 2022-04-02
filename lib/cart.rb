class Cart

  def initialize()
    @pay = 0
    @products = []
  end

  def put(product)
    @products << product
    @pay += product.price
    product.amount -= 1
  end

  def to_s
    puts 'Вы купили'
    @products.each { |product| puts product }
    puts "С вас #{@pay}"
  end
end
