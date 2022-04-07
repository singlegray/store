if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/product_collection'
require_relative 'lib/cart'

collection = ProductCollection.from_dir("#{__dir__}/data")

collection.sort!(by: :title, order: :asc)

cart = Cart.new

loop do
  collection.remove_out_of_stock!

  puts <<~COLLECTION
    Что хотите купить:

    #{collection}
    0. Выход

  COLLECTION

  print '> '

  user_choice = $stdin.gets.to_i

  break if user_choice <= 0

  chosen_product = collection[user_choice]

  next if chosen_product.nil?

  cart << chosen_product
  chosen_product.amount -= 1

  puts <<~SUBTOTAL
    Вы выбрали: #{chosen_product}

    Всего товаров на сумму: #{cart.total} руб.

  SUBTOTAL
end

puts <<~TOTAL
  Вы купили:

  #{cart}

  С Вас — #{cart.total} руб. Спасибо за покупки!
TOTAL
