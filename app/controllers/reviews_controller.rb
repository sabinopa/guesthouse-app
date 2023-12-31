class ReviewsController < ApplicationController
  before_action :authenticate_host!, only: [:host_reviews, :create_answer]
  before_action :authenticate_guest!, only: [:new, :create]
  before_action :set_booking, only: [:new, :create]
  before_action :check_guest, only: [:new, :create]
  before_action :only_after_checkout, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    review_params = params.require(:review).permit(:rating, :comment)
    @review = @booking.create_review(review_params)
    
    if @review.save
      return redirect_to my_bookings_path, notice: 'Avaliação salva com sucesso!'
    else 
      flash.now[:alert] = 'Não foi possível salvar a sua avaliação.'
      render :new
    end
  end

  def host_reviews
    @reviews = current_host.guesthouse.reviews
  end

  def create_answer
    @review = Review.find(params[:id])
    @booking = @review.booking
    @review.answer = params[:review][:answer]

    if @review.save
      return redirect_to host_reviews_path, notice: 'Resposta salva com sucesso!'
    else
      flash.now[:alert] = 'Resposta não cadastrada.'
      render :answer
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
    if @booking.present?
      @room = @booking.room
      @guesthouse = @booking.room.guesthouse
    end
  end

  def only_after_checkout
    if @booking.status != 'done'
      redirect_to my_bookings_path, alert: 'Desculpe, mas você não tem permissão para realizar essa ação.'
    end
  end

  def check_guest
    if @booking.guest != current_guest
      redirect_to my_bookings_path, alert: 'Desculpe, mas você não tem permissão para realizar essa ação.'
    end
  end
end