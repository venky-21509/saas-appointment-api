class AppointmentsController < ApplicationController

  def index

    page = params.fetch(:page, 1).to_i
    per_page = 5

    scope = current_user.admin? ? Appointment.all : current_users.appointments

     appointments = scope
                   .order(created_at: :desc)
                   .offset((page - 1) * per_page)
                   .limit(per_page)

  render json: {
    page: page,
    per_page: per_page,
    data: appointments
  }
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
