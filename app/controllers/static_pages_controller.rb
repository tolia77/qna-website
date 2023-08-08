class StaticPagesController < ApplicationController
  def home
    @topics = Category.all
    @topics = @topics.sort_by {|topic| topic.questions.size}
    @topics = @topics.reverse[0, 10]

  end
end
