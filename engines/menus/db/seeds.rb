# USER
user = Erp::User.first
# CREATE MENU SIDEBAR
puts "Create menu"
# Sản phẩm HP
father1 = Erp::Menus::Menu.create(
  name: "Sản Phẩm HP",
  creator_id: user.id
)
  # Máy Tính Xách Tay - Laptop
  father11 = father1.children.create(
    name: "Máy Tính Xách Tay - Laptop",
    creator_id: user.id
  )
    father11.children.create(
      name: "Dòng Elitebook",
      creator_id: user.id
    )
    father11.children.create(
      name: "Dòng Pavilion",
      creator_id: user.id
    )
    father11.children.create(
      name: "Dòng Probook",
      creator_id: user.id
    )
    father11.children.create(
      name: "Dòng Envy",
      creator_id: user.id
    )         
    father11.children.create(
      name: "Dòng Khác",
      creator_id: user.id
    )
  # Máy Tính Để Bàn
  father12 = father1.children.create(
    name: "Máy Tính Để Bàn",
    creator_id: user.id
  )
    father12.children.create(
      name: "Máy Tính Cá Nhân - PC",
      creator_id: user.id
    )
    father12.children.create(
      name: "Máy Tính Chuyên Dụng - Workstation",
      creator_id: user.id
    )
    father12.children.create(
      name: "Máy Tính All In One",
      creator_id: user.id
    )
    father12.children.create(
      name: "Máy Tính Thin Client",
      creator_id: user.id
    )
  # Máy Chủ - Server
  father13 = father1.children.create(
    name: "Máy Chủ - Server",
    creator_id: user.id
  )
  # Thiết Bị Chuyển Mạch - Switch
  father14 = father1.children.create(
    name: "Thiết Bị Chuyển Mạch - Switch",
    creator_id: user.id
  ) 
  # Sản Phẩm Lưu Trữ - Storage
  father15 = father1.children.create(
    name: "Sản Phẩm Lưu Trữ - Storage",
    creator_id: user.id
  )
    father15.children.create(
      name: "NAS Storage",
      creator_id: user.id
    )
    father15.children.create(
      name: "SAN Storage",
      creator_id: user.id
    )
    father15.children.create(
      name: "Phụ Kiện Storage",
      creator_id: user.id
    ) 
  # Sản Phẩm Văn Phòng
  father16 = father1.children.create(
    name: "Sản Phẩm Văn Phòng",
    creator_id: user.id
  )
    father16.children.create(
      name: "Máy In",
      creator_id: user.id
    )
    father16.children.create(
      name: "Máy In Phun",
      creator_id: user.id
    )
    father16.children.create(
      name: "Mực In",
      creator_id: user.id
    )
    father16.children.create(
      name: "Máy Scan",
      creator_id: user.id
    )
    father16.children.create(
      name: "Máy Vẽ Kỹ Thuật",
      creator_id: user.id
    )
  # Màn Hình Máy Tính
  father17 = father1.children.create(
    name: "Màn Hình Máy Tính",
    creator_id: user.id
  )
  # Phụ Kiện & Sản Phẩm Khác
  father18 = father1.children.create(
    name: "Phụ Kiện & Sản Phẩm Khác",
    creator_id: user.id
  )
    father18.children.create(
      name: "Máy Tính Tiền - RPOS",
      creator_id: user.id
    )
    father18.children.create(
      name: "Module Quang SFP",
      creator_id: user.id
    )
    father18.children.create(
      name: "Bộ Sạc Nguồn",
      creator_id: user.id
    )
    father18.children.create(
      name: "Pin Nguồn",
      creator_id: user.id
    )
    father18.children.create(
      name: "Bàn Phím - Chuột",
      creator_id: user.id
    )
    father18.children.create(
      name: "Ổ Đĩa Cứng",
      creator_id: user.id
    )      
    father18.children.create(
      name: "Loa - Tai Nghe",
      creator_id: user.id
    )
    father18.children.create(
      name: "Balo Laptop",
      creator_id: user.id
    )
# MÁY TÍNH
father2 = Erp::Menus::Menu.create(
  name: "Máy Tính",
  creator_id: user.id
)
  # MÁY TÍNH BẢNG - TABLET
  father21 = father2.children.create(
    name: "Máy Tính Bảng - Tablet",
    creator_id: user.id
  )
  # MÁY TÍNH XÁCH TAY - LAPTOP
  father22 = father2.children.create(
    name: "Máy Tính Xách Tay - Laptop",
    creator_id: user.id
  )
    # ACER
    father22.children.create(
      name: "Acer",
      creator_id: user.id
    )
    # ASUS
    father22.children.create(
      name: "Asus",
      creator_id: user.id
    )
    # HP
    father22.children.create(
      name: "HP",
      creator_id: user.id
    )
    # DELL
    father22.children.create(
      name: "Dell",
      creator_id: user.id
    )
    # LENOVO
    father22.children.create(
      name: "Lenovo",
      creator_id: user.id
    )
    # TOSHIBA
    father22.children.create(
      name: "Toshiba",
      creator_id: user.id
    )
    # MÁY TÍNH ALL IN ONE
    father22.children.create(
      name: "ALL IN ONE",
      creator_id: user.id
    )
    # KHÁC
    father22.children.create(
      name: "Khác",
      creator_id: user.id
    )
  # PHỤ KIỆN MÁY TÍNH BẢNG
  father23 = father2.children.create(
    name: "Phụ Kiện Máy Tính Bảng",
    creator_id: user.id
  )
    father23.children.create(
      name: "Bao da - Ốp lưng",
      creator_id: user.id
    )
    father23.children.create(
      name: "Bàn phím - Docking",
      creator_id: user.id
    )
  # PHỤ KIỆN MÁY TÍNH XÁCH TAY
  father24 = father2.children.create(
    name: "Phụ Kiện Máy Tính Xách Tay",
    creator_id: user.id
  )
    father24.children.create(
      name: "Ram",
      creator_id: user.id
    )
    father24.children.create(
      name: "DVD",
      creator_id: user.id
    )
    father24.children.create(
      name: "Pin",
      creator_id: user.id
    )
    father24.children.create(
      name: "Adapter",
      creator_id: user.id
    )
    father24.children.create(
      name: "Keyboard",
      creator_id: user.id
    )
    father24.children.create(
      name: "Khóa - Đèn bàn",
      creator_id: user.id
    )
    father24.children.create(
      name: "Quạt Tản Nhiệt",
      creator_id: user.id
    )
    father24.children.create(
      name: "Túi xách - Balo - Túi đệm",
      creator_id: user.id
    )
    father24.children.create(
      name: "Bàn Notebook",
      creator_id: user.id
    )
    father24.children.create(
      name: "LCD",
      creator_id: user.id
    )
# THIẾT BỊ TIN HỌC
father3 = Erp::Menus::Menu.create(
  name: "Thiết Bị Tin Học",
  creator_id: user.id
)
# THIẾT BỊ MẠNG
father4 = Erp::Menus::Menu.create(
  name: "Thiết Bị Mạng",
  creator_id: user.id
)
# THIẾT BỊ KỸ THUẬT SỐ
father5 = Erp::Menus::Menu.create(
  name: "Thiết Bị Kỹ Thuật Số",
  creator_id: user.id
)
# THIẾT BỊ VĂN PHÒNG
father6 = Erp::Menus::Menu.create(
  name: "Thiết Bị Văn Phòng",
  creator_id: user.id
)
# ĐIỆN THOẠI
father7 = Erp::Menus::Menu.create(
  name: "Điện Thoại",
  creator_id: user.id
)
# THÔNG TIN KHUYẾN MÃI
father8 = Erp::Menus::Menu.create(
  name: "Thông Tin Khuyến Mãi",
  creator_id: user.id
)
# DỊCH VỤ SỬA CHỮA
father9 = Erp::Menus::Menu.create(
  name: "Dịch Vụ Sửa Chữa",
  creator_id: user.id
)