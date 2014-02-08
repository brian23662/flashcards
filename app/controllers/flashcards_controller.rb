class FlashcardsController < ApplicationController
  before_filter :authorise
  
  def index
  	@flashcard = Flashcard.new
  	
    if params[:deck_id] != nil
      @flashcards = @current_user.flashcards.where deck_id: params[:deck_id]
    else
      @flashcards = @current_user.flashcards.all
    end
  end

  def create
  	Flashcard.create flashcard_params
  	redirect_to :back
  end

  def edit
  	@flashcard = Flashcard.find params[:id]
  end

  def update
  	flashcard = Flashcard.find params[:id]
  	if flashcard.update_attributes flashcard_params
  		redirect_to flashcards_path, notice: 'Your flashcard has successfully been updated.'
  	else
  		redirect_to :back, notice: 'There was an error updating your flashcard.'
  	end
  end

  def destroy
    @flashcard = Flashcard.find params[:id]
  	@flashcard.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Flashcard has been deleted.' }
      format.js
    end
  end

  def flashcard_params
    params.require(:flashcard).permit(:front, :back, :deck_id)
  end
end
