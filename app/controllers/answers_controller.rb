class AnswersController < ApplicationController
  
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
      redirect_to @question
    end
    
  end 
end