class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]
  before_action :check_logged_in, only: %i[ new create edit update destroy ]
  before_action only: %i[ edit update destroy ] do
    check_user(@question)
  end

  # GET /questions or /questions.json
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @questions = @category.questions.reverse
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @questions = @user.questions.reverse
    else
      @questions = Question.all.reverse
    end
  end

  # GET /questions/1 or /questions/1.json
  def show
    @answer = Answer.new
    question = Question.find(params[:id])
    @answers = question.answers
  end

  # GET /questions/new
  def new
    @categories = []
    Category.all.each do |category|
      @categories << [category.name, category.id]
    end
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @categories = []
    Category.all.each do |category|
      @categories << [category.name, category.id]
    end
  end

  # POST /questions or /questions.json
  def create
    @question = current_user.questions.build(question_params)
    @categories = []
    Category.all.each do |category|
      @categories << [category.name, category.id]
    end
    @question.category_id - Category.find_by(name: params[:category_id]).id
    respond_to do |format|
      if @question.save
        format.html { redirect_to question_url(@question), notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    @categories = []
    Category.all.each do |category|
      @categories << [category.name, category.id]
    end
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :content, :category_id, :user_id)
    end

end
