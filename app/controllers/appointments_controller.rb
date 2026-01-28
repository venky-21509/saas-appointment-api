class AppointmentsController < ApplicationController

  def index
    render json: current_user.appointments 
  end

  def create
    appointment = current_user.appointments.create!(appointment_params)
    render json: appointment, status: :created
  end

  private 

  def appointment_params
    params.require(:appointment).permit(:title,:scheduled_at)
  end

end
