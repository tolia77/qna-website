class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :check_is_admin, only: %i[ new create edit update destroy]

  def search
    @categories = Category.where("LOWER(name) LIKE ?", "%#{params[:key].downcase}%")
    respond_to do |format|
      format.turbo_stream { render :search, locals: { categories: @categories } }
    end
  end

  # GET /categories or /categories.json
  def index
    @categories = Category.paginate(page: params[:page], per_page: 30)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html {
          redirect_to category_url(@category)
          flash[:success] =  "Issue was successfully destroyed." "Category was successfully created."
        }
        format.turbo_stream { render :create, locals: { category: @category } }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity, locals: {category: @category} }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html {
          redirect_to category_url(@category)
          flash[:success] =  "Issue was successfully destroyed." "Category was successfully updated."
        }
        format.turbo_stream { render :update, locals: { category: @category } }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity, locals: { category: @category } }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html {
        redirect_to categories_url
        flash[:success] =  "Issue was successfully destroyed." "Category was successfully destroyed."
      }
      format.turbo_stream { render :destroy, locals: { category: @category } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :image)
    end
end
