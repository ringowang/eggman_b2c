class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation # 虚拟属性

  validates :email, presence: { message: '邮箱不能为空' }
  validates :email, uniqueness: true
  validates :email, format: { with: /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, message: '邮箱不合法' },
                    if: proc { |user| !user.email.blank? }

  validates :password,
            presence: { message: '密码不能为空' },
            if: :need_validate_password
  validates :password_confirmation,
            presence: { message: '密码确认不能为空' },
            if: :need_validate_password
  validates :password,
            confirmation: { message: '密码不一致' }, # 这个验证创建一个虚拟属性，其名字为要验证的属性名后加 _confirmation。
            if: :need_validate_password
  validates :password,
            length: { minimum: 6, message: '密码最短为6位' },
            if: :need_validate_password

  def username
    self.email.split('@').first
  end

  private

  def need_validate_password # 在修改之类的时候，因为是虚拟属性，所以在数据库里面没有值，但还是会触发校验，这个判断就是不让触发
    self.new_record? || # 其实就是new_record?判断id是否为空, 由rails提供
      (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
