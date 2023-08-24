class IssuesController < ApplicationController
  before_action :set_issue, only: %i[ show edit update destroy ]
  before_action :check_logged_in, only: %i[ new create index destroy ]
  before_action only:  %i[ show destroy ] do
    check_user(@issue)
  end
  before_action :check_is_admin, only: %i[ index ]

  # GET /issues or /issues.json
  def show
  end
  def index
    if params[:user_id]
      @issues = User.find(params[:user_id]).issues
    else
      @issues = Issue.all
    end
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # POST /issues or /issues.json
  def create
    @issue = Issue.new(issue_params)
    @issue.user_id = current_user.id
    respond_to do |format|
      if @issue.save
        format.html {
          flash[:success] = "Issue was successfully created."
          redirect_to root_path
        }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    @issue.destroy

    respond_to do |format|
      format.html {
        flash[:success] =  "Issue was successfully destroyed."
        redirect_to issues_url
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def issue_params
      params.require(:issue).permit(:category, :description, :user_id)
    end
end
