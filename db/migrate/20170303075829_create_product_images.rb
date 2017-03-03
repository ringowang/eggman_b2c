class CreateProductImages < ActiveRecord::Migration[5.0]
  def change
    create_table :product_images do |t|
      t.belongs_to :product
      t.integer :weight, default: 0 # 那张图片作主图，显示在搜索页面，即描述展示顺序
      t.attachment :image # paperclip带的
      t.timestamps
    end
  end
end
