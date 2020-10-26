Erp::User.class_eval do
    has_many :comments, class_name: 'Erp::Articles::Comment', foreign_key: 'user_id'
end