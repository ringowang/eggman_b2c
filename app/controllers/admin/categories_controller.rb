class Admin::CategoriesController < Admin::BaseController
  before_action :find_root_categories, only: [:new, :create, :edit, :update]
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    if params[:id].blank?
      # 只列出一级分类
      @categories = Category.roots
    else
      @category = Category.find_by_id(params[:id])
      @categories = @category.children
    end
    @categories = @categories.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: 'desc')
  end

  def new
    @category = Category.new
  end

  def create
    # permit! 所有都接受不过滤
    @category = Category.new(params.require(:category).permit!)
    if @category.save
      flash[:notice] = '保存成功'
      redirect_to admin_categories_path
    else
      render action: :new
    end
  end

  def edit
    # new edit 用的一张表
    render action: :new
  end

  def update
    @category.attributes = params.require(:category).permit!
    # 这个是在失败的情况render new的时候 需要把root_categories传给页面，现在放到before_action里了
    # @root_categories = Category.roots.order(id: 'desc')
    if @category.save
      flash[:notice] = '修改成功'
      redirect_to admin_categories_path
    else
      render action: :new
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = '删除成功'
      redirect_to admin_categories_path
    else
      flash[:notice] = '删除失败'
      # 重定向到来源页面
      redirect_to :back
    end
  end

  private

  def find_root_categories
    @root_categories = Category.roots.order(id: 'desc')
  end

  def find_category
    @category = Category.find_by_id(params[:id])
  end
end
