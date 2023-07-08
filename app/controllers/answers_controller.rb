class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy ]
  before_action :check_logged_in, only: %i[ new create edit update destroy ]
  before_action only: %i[ edit destroy ] do
    check_user(@answer)
  end
  before_action :only_accepted_changed, only: [:update]
  def index
    @answers = Question.find(params[:question_id]).answers
  end
  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
  end
  # GET /answers/1/edit
  def edit
    @question = Answer.find(params[:id]).question
  end

  # POST /answers or /answers.json
  def create
    @answer = current_user.answers.build(answer_params)
    @answer.question_id = params[:question_id]
    @question = Question.find(params[:question_id])
    respond_to do |format|
      if @answer.save
        format.html {
          flash[:success] = "Answer was successfully created."
          redirect_to question_answers_path(@question)
        }
        format.turbo_stream {
          render :create, locals: {answer: @answer, question: @question}
        }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html {
          flash[:danger] = 'You have already left an answer'
          redirect_to question_answers_path(@question)
        }
        format.turbo_stream {
          render :new, status: :unprocessable_entity, locals: {answer: @answer, question: @question}
        }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html {
          flash[:success] = "Answer was successfully updated."
          redirect_to @answer.question
        }
        format.turbo_stream {
          render :update, locals: { answer: @answer, question: @answer.question }
        }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream {
          render :edit, status: :unprocessable_entity, locals: { answer: @answer, question: @answer.question }
        }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to @answer.question, notice: "Answer was successfully destroyed." }
      format.turbo_stream {
        render :destroy, locals: { answer: @answer, question: @answer.question }
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:text, :accepted, :user_id, :question_id)
    end
end
