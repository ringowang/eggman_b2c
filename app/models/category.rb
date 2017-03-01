class Category < ApplicationRecord
  validates :title, presence: { message: '名称不能为空' }
  validates :title, uniqueness: { message: '名称不能重复' }

  # orphan_strategy: :destroy 是gem自带的策略，删除父分类，子分类一起没
  has_ancestry orphan_strategy: :destroy

  has_many :products, dependent: :destroy

  before_validation :correct_ancestry

  private

  def correct_ancestry
    self.ancestry = nil if self.ancestry.blank?
  end
end
