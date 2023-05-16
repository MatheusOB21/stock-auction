class QuestionsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]

  def new
    @lot = Lot.find(params[:lot_id])
    @question = Question.new()
  end

  def create
    @lot = Lot.find(params[:lot_id])
    
    question_params = params.require(:question).permit(:question)
    @question = Question.new(question_params)
    @question.lot = @lot

    if @question.save
      redirect_to @lot, notice: 'Sua pergunta foi registrada!'
    else
      flash.now[:notice] = 'Sua pergunta não foi registrada!'
      render 'new'
    end
  end

  def index
    @questions = Question.where.missing(:answer)
  end
end