class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :check_logged_in, only: %i[ new edit update destroy ]
  before_action only: %i[edit update destroy] do
    check_user(@comment)
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @answer = Answer.find(params[:answer_id])
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.answer_id = params[:answer_id]
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.answer.question, notice: "Comment was successfully created." }
        format.turbo_stream { render :create, locals: { comment: @comment } }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity, locals: { comment: @comment } }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.answer.question, notice: "Comment was successfully updated." }
        format.turbo_stream { render :update, locals: { comment: @comment } }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity, locals: { comment: @comment } }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.answer.question, notice: "Comment was successfully destroyed." }
      format.turbo_stream { render :destroy, locals: { comment: @comment } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:text, :user_id, :answer_id)
    end
end
