class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation # 虚拟属性

  validates :email, presence: true, message: '邮箱不能为空'
  validates :email, uniqueness: true

  validates :password, presence: true, message: '密码不能为空',
    if: :need_validate_password
  validates :password_confirmation, presence: true, message: '密码确认不能为空',
    if: :need_validate_password
  validates :password, confirmation: true, message: '密码不一致', # 这个验证创建一个虚拟属性，其名字为要验证的属性名后加 _confirmation。
    if: :need_validate_password
  validates :password, length: { minimum: 6 }, message: "密码最短为6位",
    if: :need_validate_password

  private

  def need_validate_password
    self.new_record? || # 其实就是new_record?判断id是否为空, 由rails提供
      (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
