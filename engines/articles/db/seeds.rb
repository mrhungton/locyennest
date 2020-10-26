# USER
user = Erp::User.first

# ARTICLES
puts "Create sample categories article"
Erp::Articles::Category.where(name: "Chính sách bảo hành").destroy_all
category1 = Erp::Articles::Category.create(name: "Chính sách bảo hành", alias: Erp::Articles::Category::ALIAS_WARRANTY, creator_id: user.id)
Erp::Articles::Category.where(name: "Quy định & Hình thức thanh toán").destroy_all
category2 = Erp::Articles::Category.create(name: "Quy định & Hình thức thanh toán", alias: Erp::Articles::Category::ALIAS_PAYMENT, creator_id: user.id)
Erp::Articles::Category.where(name: "Chính sách vận chuyển, giao nhận").destroy_all
category3 = Erp::Articles::Category.create(name: "Chính sách vận chuyển, giao nhận", alias: Erp::Articles::Category::ALIAS_DELIVERY, creator_id: user.id)
Erp::Articles::Category.where(name: "Chính sách đổi trả hàng và hoàn tiền").destroy_all
category4 = Erp::Articles::Category.create(name: "Chính sách đổi trả hàng và hoàn tiền", alias: Erp::Articles::Category::ALIAS_RETURN_REFUND, creator_id: user.id)
Erp::Articles::Category.where(name: "Quy định bảo mật thông tin").destroy_all
category5 = Erp::Articles::Category.create(name: "Quy định bảo mật thông tin", alias: Erp::Articles::Category::ALIAS_SECURITY, creator_id: user.id)
Erp::Articles::Category.where(name: "Các điều khoản & Điều kiện").destroy_all
category6 = Erp::Articles::Category.create(name: "Các điều khoản & Điều kiện", alias: Erp::Articles::Category::ALIAS_TERMS_CONDITIONS, creator_id: user.id)
Erp::Articles::Category.where(name: "Câu hỏi thường gặp").destroy_all
category7 = Erp::Articles::Category.create(name: "Câu hỏi thường gặp", alias: Erp::Articles::Category::ALIAS_FAQ, creator_id: user.id)

Erp::Articles::Category.where(name: "Tín đồ công nghệ").destroy_all
category8 = Erp::Articles::Category.create(name: "Tín đồ công nghệ", alias: Erp::Articles::Category::ALIAS_BLOG, creator_id: user.id)
Erp::Articles::Category.where(name: "Chia sẻ kinh nghiệm").destroy_all
category9 = Erp::Articles::Category.create(name: "Chia sẻ kinh nghiệm", alias: Erp::Articles::Category::ALIAS_BLOG, creator_id: user.id)

puts "Create sample articles"
Erp::Articles::Article.where(name: "Chính sách bảo hành").destroy_all
article1 = Erp::Articles::Article.create(name: "Chính sách bảo hành", content: "Đang cập nhật...", category_id: category1.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Quy định & Hình thức thanh toán").destroy_all
article2 = Erp::Articles::Article.create(name: "Quy định & Hình thức thanh toán", content: "Đang cập nhật...", category_id: category2.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Chính sách vận chuyển, giao nhận").destroy_all
article3 = Erp::Articles::Article.create(name: "Chính sách vận chuyển, giao nhận", content: "Đang cập nhật...", category_id: category3.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Chính sách đổi trả hàng và hoàn tiền").destroy_all
article4 = Erp::Articles::Article.create(name: "Chính sách đổi trả hàng và hoàn tiền", content: "Đang cập nhật...", category_id: category4.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Quy định bảo mật thông tin").destroy_all
article5 = Erp::Articles::Article.create(name: "Quy định bảo mật thông tin", content: "Đang cập nhật...", category_id: category5.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Điều khoản thứ nhất").destroy_all
article6 = Erp::Articles::Article.create(name: "Điều khoản thứ nhất", content: "Đang cập nhật...", category_id: category6.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Điều khoản thứ hai").destroy_all
article6 = Erp::Articles::Article.create(name: "Điều khoản thứ hai", content: "Đang cập nhật...", category_id: category6.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Câu hỏi thứ nhất").destroy_all
article7 = Erp::Articles::Article.create(name: "Câu hỏi thứ nhất", content: "Đang cập nhật...", category_id: category7.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Câu hỏi thứ hai").destroy_all
article7 = Erp::Articles::Article.create(name: "Câu hỏi thứ hai", content: "Đang cập nhật...", category_id: category7.id, creator_id: user.id)

Erp::Articles::Article.where(name: "Sự kiện ra mắt TimHangCongNghe.vn").destroy_all
article8 = Erp::Articles::Article.create(
            name: "Sự kiện ra mắt TimHangCongNghe.vn",
            content: "<p>Nội dung đang được cập nhật...</p>",
            category_id: category8.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Giải pháp tối ưu dành cho các tín đồ yêu công nghệ").destroy_all
article9 = Erp::Articles::Article.create(
            name: "Giải pháp tối ưu dành cho các tín đồ yêu công nghệ",
            content: "<p>Nội dung đang được cập nhật...</p>",
            category_id: category9.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Marchex Launches Call Analytics For Search").destroy_all
article8 = Erp::Articles::Article.create(
            name: "Marchex Launches Call Analytics For Search",
            content: "<p>Nội dung đang được cập nhật...</p>",
            category_id: category8.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Google ra mắt Jamboard - đối thủ của Microsoft Surface Hub").destroy_all
article9 = Erp::Articles::Article.create(
            name: "Google ra mắt Jamboard - đối thủ của Microsoft Surface Hub",
            content: "<p>Nội dung đang được cập nhật...</p>",
            category_id: category9.id, creator_id: user.id)