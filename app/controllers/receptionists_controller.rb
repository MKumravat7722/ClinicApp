class ReceptionistsController < ApplicationController
    before_action :authenticate_user!
    # before_action :check_receptionist_role

    def index
        @patients = Patient.all
      # Your receptionist-specific logic here
      redirect_to doctors_path if current_user.role == 'doctor'
    end
    def patient_registrations
    @registrations = Patient.group("DATE(created_at)").count

    render json: @registrations
  end
    private
  
    def check_receptionist_role
      unless current_user.role == 'recipient'
        redirect_to root_path
        return
      end
    end
  end

