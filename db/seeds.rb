# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories_name =  ['Musica', 'Pelulas', 'Religión', 'Deportes', 'RadiO', 'TurIsmo', 'aventura', 'Comidas', 'hoTeleria']
rng = RandomNameGenerator.new
root_category = Category.create(name: 'Industrias star')
array_str = []

1..50.times do
  name = rng.compose(10)
  array_str << name
end

categories_name.each do |name|
  Category.create(name: name, parent_id: root_category.id)
end

index = 1
price = [200, 300, 400, 500, 600]

1..5000.times do
  name = rng.compose(3)
  last = array_str.sample(random: SecureRandom)
  p = Product.create(price: price.sample(random: SecureRandom),
                     description: "Este es un producto muy interezante #{last}",
                     title: "#{name} #{index}")

  category_1 = Category.where(parent_id: root_category.id).sample(random: SecureRandom)

  p.category_products.create(category_id: category_1.id)

  category_2 = Category.where(parent_id: root_category.id)
                       .where.not(id: category_1.id)
                       .sample(random: SecureRandom)

  p.category_products.create(category_id: category_2.id)
  index += 1
end

Product.reindex
