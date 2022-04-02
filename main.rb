if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/film'
require_relative 'lib/disc'
require_relative 'lib/product_collection'
require_relative 'lib/cart'

collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')

collection.sort!(by: :price, order: :asc)

choice = 1

cart = Cart.new

until choice == 0
  puts 'Что хотите купить?'
  collection.to_a.each_with_index do |product, index|
    puts "#{index + 1} #{product}"
  end
  puts 'Для завершения введите 0'
  choice = gets.to_i
  if choice !=0
    cart.put(collection.to_a[choice - 1])
  end
end

puts cart
