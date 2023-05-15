class QuestionsController < ApplicationController
  before_action :authenticate_user!, only:[:new]

  def new
    @lot = Lot.find(params[:lot_id])
    @question = Question.new()
  end

  def create
    @lot = Lot.find(params[:lot_id])
    question_params = params.require(:question).permit(:question)
    @question = Question.new(question_params)
    @question.lot = @lot

    @question.save!
    redirect_to @lot
  end
end