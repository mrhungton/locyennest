# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Load other engines seed
Erp::Core::Engine.load_seed
Rails::Engine.subclasses.to_a.each do |class_name|
  if class_name.to_s.split("::").first == "Erp"
    name = class_name.to_s.split("::").second
    puts "Loading seed: #{name}"
    "Erp::#{name.camelize}::Engine".constantize.load_seed
  end
end
