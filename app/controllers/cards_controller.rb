class CardsController < ApplicationController
  before_action :set_deck, except: [:new_deck, :create_deck]
  before_action :set_card, except: [:index, :new, :new_deck, :create, :create_deck]

  def index
    @cards = @deck.cards
  end

  def show
  end

  def new
    @card = Card.new
  end

  def new_deck
    @deck = current_user.decks.new
    @card = Card.new
  end

  def create_deck
    @deck = current_user.decks.create(title: params[:card][:deck][:title])
    @card = @deck.cards.new(card_params)
    if @card.save
      redirect_to deck_cards_path(@deck)
    else
      render "new_deck"
    end
  end

  def edit
  end

  def create
    @card = @deck.cards.new(card_params)
    if @card.save
      redirect_to deck_cards_path(@deck)
    else
      render "new"
    end
  end

  def update
    if @card.update(card_params)
      redirect_to deck_cards_path(@deck)
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to deck_cards_path(@deck)
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text,
                                 :review_date, :image)
  end

  def set_card
    @card = @deck.cards.find(params[:id])
  end

  def set_deck
    @deck = current_user.decks.find(params[:deck_id])
  end
end
