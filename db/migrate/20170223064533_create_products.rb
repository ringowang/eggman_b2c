class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :title
      t.string :status, default: 'off' # 商品状态，上架下架之类的
      t.integer :amount, default: 0 # 库存数量
      t.string :uuid # 商品序列号，暴露给前端
      t.decimal :msrp, precision: 10, scale: 2 # 市场建议零售价，原价现价中的原价 小数
      t.decimal :price, precision: 10, scale: 2
      t.text :description
      t.timestamps
    end

    add_index :products, [:status, :category_id]
    add_index :products, [:category_id]
    add_index :products, [:uuid], unique: true
    add_index :products, [:title]
  end
end
