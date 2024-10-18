# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "seedの実行を開始"
olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
end

猫達の森 = DonationDestination.find_or_create_by!(name: "猫達の森") do |donation_destination|
 donation_destination.location = "akita"
end

猫三昧 = DonationDestination.find_or_create_by!(name: "猫三昧") do |donation_destination|
 donation_destination.location = "osaka"
end

ヤマネコ本舗 = DonationDestination.find_or_create_by!(name: "ヤマネコ本舗") do |donation_destination|
 donation_destination.location = "kagoshima"
end


食品 = Genre.find_or_create_by!(name:"食品")
化粧品 = Genre.find_or_create_by!(name:"化粧品")
キッチン用品 = Genre.find_or_create_by!(name:"キッチン用品")
インテリア = Genre.find_or_create_by!(name:"インテリア")
日用雑貨 = Genre.find_or_create_by!(name:"日用雑貨")
ペット用品 = Genre.find_or_create_by!(name:"ペット用品")


猫まんま = Item.find_or_create_by!(name: "猫まんま") do |item|
 item.genre = 食品
 item.donation_destination = 猫達の森
 item.price = 800
end

ほかほかにゃんこ = Item.find_or_create_by!(name: "ほかほかにゃんこ") do |item|
 item.genre = 日用雑貨
 item.donation_destination = 猫三昧
 item.price = 1000
end

にゃんこいす = Item.find_or_create_by!(name: "にゃんこいす") do |item|
 item.genre = インテリア
 item.donation_destination = ヤマネコ本舗
 item.price = 1200
end


Post.find_or_create_by!(title: "test1") do |post|
  post.body = "とても食べやすかったです！"
  post.user = olivia
  post.item = 猫まんま
  post.star = 3
  post.tag = "love"
  post.private = "false"
end

Post.find_or_create_by!(title: "test2") do |post|
  post.body = "冬場には重宝します。"
  post.user = james
  post.item = ほかほかにゃんこ
  post.star = 5
  post.tag = "warm"
  post.private = "false"
end

Post.find_or_create_by!(title: "test3") do |post|
  post.body = "すぐに壊れてしまいました。"
  post.user = lucas
  post.item = にゃんこいす
  post.star = 1
  post.tag = "love"
  post.private = "false"
end

admin1 = Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
end

puts "seedの実行が完了しました"