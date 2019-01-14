class Task < ApplicationRecord

  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }

  validates :title, presence: true, length: { maximum: 20}
  validates :content, presence: true, length: { maximum: 200}
  validates :status, presence: true
  validates :priority, presence:true

  #past_にNo method errorが出るので、一旦コメントアウト
  #validate :limit_cannot_be_in_the_past

  scope :desc_order, -> { order("tasks.created_at DESC") }
  scope :limit_order, -> { order("tasks.limit DESC") }

  def limit_cannot_be_in_the_past
    if limit.past?
      errors.add(:limit, "に過去の日付は登録できません")
    end
  end

end
