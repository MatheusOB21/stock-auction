class QuestionsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  before_action :question_params, only:[:show, :hidden, :show_on]

  def new
    @lot = Lot.find(params[:lot_id])
    @question = Question.new()

    if current_user.block?
      redirect_to @lot, notice: 'Sua conta está suspensa, não pode dar fazer pergunta!'
    elsif current_user.is_admin
      redirect_to @lot, notice: "Usuário admin não pode fazer perguntas!"
    end

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

  def show
  end

  def hidden
    @question.hidden!
    redirect_to questions_path, notice: "Pergunta ocultada com sucesso!"
  end
  
  def show_on
    @question.show!
    redirect_to questions_path, notice: "Pergunta visível com sucesso!"
  end

  private

  def question_params
    @question = Question.find(params[:id])
  end
end