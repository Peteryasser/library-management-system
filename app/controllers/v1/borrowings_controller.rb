class V1::BorrowingsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_borrowing, only: [:show, :update, :destroy]
    before_action :check_admin, only: [:update, :destroy]
  
    def index
      @borrowings = Borrowing.all
      render json: @borrowings
    end
  
    def show
      render json: @borrowing
    end
  
    def create
      @borrowing = current_user.borrowings.new(borrowing_params)
      @borrowing.status = 'pending'
      if @borrowing.save!
        UserMailer.borrow_request_notification(current_user, @borrowing).deliver_now
        render json: @borrowing, status: :created
      else
        render json: @borrowing.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @borrowing.status = params[:status]
      if @borrowing.status == 'approved'
        @borrowing.approved_date = DateTime.now
        @borrowing.return_date = @borrowing.approved_date + @borrowing.number_of_days.days
        @borrowing.approved_by = current_user
        @borrowing.user.update(can_borrow: false)
      end
      if @borrowing.status == 'returned'
        @borrowing.user.update(can_borrow: true)
      @borrowing.is_returned_on_time = true  if !@borrowing.is_returned_on_time
      end
      if @borrowing.save!
        render json: @borrowing
      else
        render json: @borrowing.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @borrowing.destroy
    end

  
    private
  
    def set_borrowing
      @borrowing = Borrowing.find(params[:id])
    end
  
    def check_admin
      render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user.library_admin?
    end
  
    def borrowing_params
      params.require(:borrowing).permit(:book_id, :number_of_days)
    end
  end
  