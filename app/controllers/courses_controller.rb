class CoursesController < ApplicationController
  def index
    @courses = Course.all.order(:title)
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to action: :index, notice: 'Kurss ir izviedots'
    else
      render :new
    end
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)
      redirect_to action: :index, notice: 'Kursa ieraksts veiksmīgi labots'
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    redirect_to action: :index
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :start_date, :end_date, :min_number, :max_number, :user_id)
  end
end
