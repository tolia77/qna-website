module AnswersHelper
  def current_user_answer
    current_user.answers.find_by(question_id: params[:id]) if user_signed_in?
  end

  def only_accepted_changed
    unless (@answer.question.user == current_user && (!@answer.text_changed? && !@answer.question_id_changed? && !@answer.user_id_changed?)) || (@answer.user == current_user && !@answer.accepted_changed?)
      render 'shared/access_denied'
    end
  end
end
