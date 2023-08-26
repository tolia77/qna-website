class StaticPagesController < ApplicationController
  def home
    @categories = Category.all
    @categories = @categories.sort_by {|category| category.questions.size}
    @categories = @categories.reverse[0, 10]
  end
end
