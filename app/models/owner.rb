class Owner < User
  has_one :establishment, foreign_key: 'user_id'
end