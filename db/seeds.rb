# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ShippingOption.find_or_create_by(name: "Fast Standard Shipping")
ShippingOption.find_or_create_by(name: "2 Day Shipping")
ShippingOption.find_or_create_by(name: "1 Day Shipping")

BillingOption.find_or_create_by(name: "Credit Card")
BillingOption.find_or_create_by(name: "PayPal")
