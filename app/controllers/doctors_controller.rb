class DoctorsController < ApplicationController
  before_action :authenticate_user!
  # before_action :check_doctor_role

  def index
    if current_user.role == 'recipient'
      redirect_to receptionists_path
    else
      cr = current_user
      if cr.nil?
        @patients = nil
        nil
      else
        @name = cr.email
        @patients = cr.patients
      end
    end
  end

  def show
    doctor = current_user.doctor
    patients = doctor.patients
    patients_by_day = patients.group_by { |patient| patient.created_at.to_date }
    patient_count_by_day = patients_by_day.transform_values(&:count)
    @data = patient_count_by_day.map { |date, count| { label: date, data: count } }
    respond_to do |format|
      format.html
      format.json { render json: @data }
    end
  end

  def check_doctor_role
    return if current_user.role == 'doctor'

    redirect_to root_path
    nil
  end
end
