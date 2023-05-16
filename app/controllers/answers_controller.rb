class AnswersController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  before_action :admin_page, only:[:new, :create]
  
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new()
  end

  def create
    @question = Question.find(params[:question_id])
    answer_params = params.require(:answer).permit(:answer)
    
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question

    if @answer.save
      redirect_to @question, notice: 'Resposta computada com sucesso!'
    end
    
  end 
end