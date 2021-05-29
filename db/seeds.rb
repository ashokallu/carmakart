# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Customer
customer_attrs =
[
  {
    "first_name"=>"Andrea",
    "last_name"=>"Beatty"
  },
  {
    "first_name"=>"Lenore",
    "last_name"=>"Breitenberg"
  },
  {
    "first_name"=>"Milan",
    "last_name"=>"Oberbrunner"
  }
]
customers = Customer.create(customer_attrs)


# ProductType
#
# Shirt
product_type_shirt_attrs = {
  name: "Shirt",
  product_attributes: ["Sleeve", "Pattern", "Fabric"]
}

product_type_shirt = ProductType.create(product_type_shirt_attrs)

# Add new brands to shirts
brands = ["Nike",
"Louis Vuitton",
"Hermes",
"Gucci",
"Zalando",
"Adidas",
"Tiffan & Co.",
"Zara",
"H&M",
"Cartier"].map {|brand_name| Brand.new(name: brand_name)}

product_type_shirt.brands << brands

# T-Shirt
product_type_t_shirt_attrs = {
  name: "T-Shirt",
  product_attributes: ["Sleeve", "Pattern", "Fabric", "Neck Type", "Ideal For"]
}

product_type_t_shirt = ProductType.create(product_type_t_shirt_attrs)

product_type_t_shirt.brands << brands

new_brands = ["Lululemon",
"Moncler",
"Chanel",
"Rolex",
"Patek Philippe",
"Prada"].map {|brand_name| Brand.new(name: brand_name)}

brands.concat(new_brands)

# Jeans
product_type_jeans_attrs = {
  name: "Jeans",
  product_attributes: ["Fabric", "Faded", "Rise", "Ideal For"]
}

product_type_jeans = ProductType.create(product_type_jeans_attrs)

product_type_jeans.brands << brands


footwear_brands = [
  "Air Jordan",
  "Reebok",
  "VANS",
  "Converse",
  "NEW BALANCE",
  "UNDER ARMOUR",
  "DC SHOES",
  "Puma"
].map {|brand_name| Brand.new(name: brand_name)}

footwear_brands.concat(Brand.where(name: ["Adidas", "Nike"]))

# Sports Shoes
product_type_sports_shoes_attrs = {
  name: "Sports Shoes",
  product_attributes: ["Occassion", "Closure"]
}

product_type_sports_shoe = ProductType.create(product_type_sports_shoes_attrs)

product_type_sports_shoe.brands << footwear_brands

# Sandals
product_type_sandals_attrs = {
  name: "Sandals",
  product_attributes: ["Ideal For", "Type for Flats", "Care instructions"]
}

product_type_sandal = ProductType.create(product_type_sandals_attrs)

product_type_sandal.brands << footwear_brands

# Shirt

product_name = [
  "Men Super Slim Fit Checkered Spread Collar Casual Shirt",
  "Men Super Slim Fit Solid Casual Shirt",
  "Men Slim Fit Solid Slim Collar Casual Shirt",
];

product_description = [
  "Durable stitch and Quality finish. This T-shirt is stitched for higher durability using the best technology in the industry. Manufactured from Cotton fabric, this T-shirt is very smooth and soft making it comfortable to wear during all Seasons. This fabric is Durable, Odorless and passed through Anti fading treatment which ensures the T-shirt color to be intact even after repeated washes",
  "Enhance your look by wearing this trendy shirt. Team it with a pair of Sharp Looking Chinos and Tassel Loafers for a Dapper Look",
  "Featuring the same 1902 Sunset pocket shape as shirts from the Levi's archives; our Sunset One Pocket is as timeless as it is versatile. This button-up staple has a classic look that works with just about any denim in your closet."
];

product_type = ProductType.find_by(name: Carmakart::Constants::ProductTypes::Shirt)
brands = product_type.brands.shuffle
product_attributes_arr = 3.times.map do
  {
    product_name: product_name.shift,
    product_description:product_description.shift,
    product_type: product_type,
    brand: brands.shift
  }
end;

products = Product.create(product_attributes_arr);

# ProductVariant
product_type = ProductType.find_by(name: Carmakart::Constants::ProductTypes::Shirt)
product_attributes = ProductType.find_by(name: Carmakart::Constants::ProductTypes::Shirt).product_attributes

colors = ["Red", "Blue", "Green", "Brown", "Pink", "Light Green"]
sizes = Carmakart::Constants::TopWearSizes
variants_hashes = []
colors.each do |color|
  sizes.each do |size|
    variants_hashes << {"Color" => color, "Size" => size, "Sleeve" => "Full Sleeve", "Pattern" => "Solid", "Fabric" => "Pure Cotton"}
  end
end;

2.times do
  product = products.shift
  product_variants_arr = []
  variants_hashes.each do |variants_hash|
    color = variants_hash["Color"]
    name = "#{product.product_name} - #{color}"
    variant_specific_attributes = variants_hash.slice!(*product_attributes)
    product_specific_attributes = variants_hash
    product_variants_arr << {
      sku_id: ProductVariant.generate_random_sku_id,
      product_type: product_type,
      product: product,
      name: name,
      variant_specific_attributes: variant_specific_attributes,
      product_specific_attributes: product_specific_attributes
    }
  end
  ProductVariant.create(product_variants_arr)
end

sleeves = ["Full Sleeve",
"Half Sleeve",
"Short Sleeve",
"3/4th Sleeve",
"Roll-up Sleeve",
"Sleeveless"]

["Solid",
"Checkered",
"Printed",
"Striped",
"Military Camouflage",
"Washed"]

["Pure Cotton",
"Denim",
"Cotton Blend",
"Pure Linen",
"Cotton Linen Blend",
"Rayon"]

ProductVariant.where('variant_specific_attributes @> ?', {Color: 'Red'}.to_json)

# T-Shirt
# ProductVariant
product_type = ProductType.find_by(name: Carmakart::Constants::ProductTypes::T_Shirt)
brands = product_type.brands;

product_names_arr = [
  "Color Block Men Round Neck T-Shirt",
  "Solid Men Polo Neck T-Shirt",
  "Solid Men Polo Neck Light T-Shirt"
];

product_description_arr = [
  "Look smart and feel comfortable by wearing this white coloured checked T-shirt for men from the house of Maniac.Made from cotton, this T-shirt comes in slim fit and will be comfortable all day long. This T-shirt can be teamed up with a pair of denims and sneakers to complete your stylish look.",
  "Durable stitch and Quality finish. This T-shirt is stitched for higher durability using the best technology in the industry. Manufactured from Cotton fabric, this T-shirt is very smooth and soft making it comfortable to wear during all Seasons. This fabric is Durable, Odorless and passed through Anti fading treatment which ensures the T-shirt color to be intact even after repeated washes.",
  "Ace weekend dressing in this solid Polo Neck T-shirt from Allen Solly by Allen Solly."
];

product_attributes_arr = 3.times.map do
  {
    product_name: product_names_arr.shift,
    product_description: product_description_arr.shift,
    product_type: product_type,
    brand: brands.sample
  }
end;

products = Product.create(product_attributes_arr);
product_attributes = ProductType.find_by(name: Carmakart::Constants::ProductTypes::T_Shirt).product_attributes

colors = ["Red", "Blue", "Green", "White"]
sizes = Carmakart::Constants::TopWearSizes
variants_hashes = []
colors.each do |color|
  sizes.each do |size|
    variants_hashes << {"Color" => color, "Size" => size, "Sleeve" => "Half Sleeve", "Pattern" => "Striped", "Fabric" => "Cotton"}
  end
end;

2.times do
  product_variant_arr = []
  product = products.shift
  variants_hashes.each do |variants_hash|
    color = variants_hash["Color"]
    name = "#{product.product_name} - #{color}"
    variant_specific_attributes = variants_hash.slice!(*product_attributes)
    product_specific_attributes = variants_hash
    product_variant_arr << {
      sku_id: ProductVariant.generate_random_sku_id,
      product_type: product_type,
      product: product,
      name: name,
      variant_specific_attributes: variant_specific_attributes,
      product_specific_attributes: product_specific_attributes
    }
  end
  ProductVariant.create(product_variant_arr)
end;

# Sports Shoes
product_type = ProductType.find_by(name: Carmakart::Constants::ProductTypes::Sports_Shoes)
brands = product_type.brands

product_names_arr = [
  "Precision 5 Basketball Shoe Basketball Shoes For Men",
  "Revolution 5 Men's Running Shoe Running Shoes For Men",
  "Elate M Running Shoes For Men"
]

product_description_arr = [
  "Upper: Mesh upper for lightweight and breathability. Midsole: lightstrike IMEVA midsole with visible adiprene providing protection from harmful impact forces.",
  "A quick first step makes all the difference. The Nike Precision 5 locks in your foot with structured materials and cushions with resilient foam. Stripped down and sculpted, the shape allows quick cuts and hard banks when you're angling for an advantage.",
  "The Nike Revolution 5 cushions your stride with soft foam to keep you running in comfort. Lightweight knit material wraps your foot in breathable support, while a minimalist design fits in just about anywhere your day takes you."
]

product_attributes_arr = 3.times.map do
  {
    product_name: product_names_arr.shift,
    product_description: product_description_arr.shift,
    product_type: product_type,
    brand: brands.sample
  }
end;
products = Product.create(product_attributes_arr);
product_attributes = ProductType.find_by(name: Carmakart::Constants::ProductTypes::Sports_Shoes).product_attributes
product_type = ProductType.find_by(name: Carmakart::Constants::ProductTypes::Sports_Shoes)

colors = ["Red", "Blue", "Green", "White", "Yellow", "Pink", "Black", "Light Green"]
sizes = Carmakart::Constants::ShoeSizes
variants_hashes = []
colors.each do |color|
  sizes.each do |size|
    variants_hashes << {"Color" => color, "Size" => size, "Occassion" => "Sports", "Closure" => "Lace-Ups"}
  end
end;

2.times do
  product_variant_arr = []
  product = products.shift
  variants_hashes.each do |variants_hash|
    color = variants_hash["Color"]
    name = "#{product.product_name} (#{color})"
    variant_specific_attributes = variants_hash.slice!(*product_attributes)
    product_specific_attributes = variants_hash
    product_variant_arr << {
      sku_id: ProductVariant.generate_random_sku_id,
      product_type: product_type,
      product: product,
      name: name,
      variant_specific_attributes: variant_specific_attributes,
      product_specific_attributes: product_specific_attributes
    }
  end
  ProductVariant.create(product_variant_arr)
end;
