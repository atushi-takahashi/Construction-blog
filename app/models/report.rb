class Report < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :question, optional: true
  
  enum category: { "不適切な内容又はスパムである": 0, "センシティブな画像を表示している": 1, "不適切又は攻撃的な内容を含んでいる": 2}
  
end
