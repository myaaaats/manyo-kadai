class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20}
  validates :content, presence: true, length: { maximum: 200}
  validates :limit, presence: true
  validate :limit_cannot_be_in_the_past

  def limit_cannot_be_in_the_past
    if limit.past?
      errors.add(:limit, "過去の日付は登録できません")
    end
  end
end
