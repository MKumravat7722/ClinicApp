class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.all
  end

  def patient_registrations
    @registrations = Patient.group("DATE(created_at)").count
    render json: @registrations
  end

  def show
    @dr = @patient.user # Fetch the associated doctor/user for the patient
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to @patient, notice: 'Patient was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Patient was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path, notice: 'Patient was successfully destroyed.'
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:name, :age, :gender, :contact_number, :date_time_of_appointment, :user_id)
  end
end
