class PatientsController < ApplicationController
    before_action :authenticate_user!
      before_action :set_patient, only: [:show, :edit, :update, :destroy]
    
      def index
        @patients = Patient.all
      end
      
      def show
        @patient = Patient.find(params[:id]) # Fetch the patient by the :id parameter
        @dr = @patient.doctor
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
    
      def delete_patient
        @patient = Patient.find(params[:id])
        @patient.destroy
        respond_to do |format|
          format.html { redirect_to receptionists_path, notice: 'Patient was successfully destroyed.' }
        
        end
      end
    
      private
    
      def set_patient
        @patient = Patient.find(params[:id])
      end
    
      def patient_params
        params.require(:patient).permit(:name, :age, :gender, :contact_number, :date_time_of_appointment, :doctor_id, :user_id)
      end
      
    end
    