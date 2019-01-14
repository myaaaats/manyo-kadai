class Task < ApplicationRecord

  validates :title, presence: true, length: { maximum: 20}
  validates :content, presence: true, length: { maximum: 200}
  validates :limit, presence: true
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
