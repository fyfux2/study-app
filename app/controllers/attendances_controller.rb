class AttendancesController < ApplicationController

  def index
    @attendances = Attendance.all.order(:created_at)
  end

  def show
    @attendance = Attendance.find(params[:id])
  end

  def new
    @attendance = Attendance.new
  end

  def edit
    @attendance = Attendance.find(params[:id])
  end

  def create
    @attendance = Attendance.new(attendance_params)

    if @attendance.save
      redirect_to action: :index, notice: 'Ieraksts izveidots'
    else
      render :new
    end
  end

  def update
    @attendance = Attendance.find(params[:id])

    if @attendance.update(attendance_params)
      redirect_to action: :index, notice: 'Ieraksts veiksmīgi labots'
    else
      render :edit
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy

    redirect_to action: :index
  end

  private

  def attendance_params
    params.require(:attendance).permit(:user_id, :course_id)
  end
end
