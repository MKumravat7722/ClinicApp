class DoctorsController < ApplicationController
before_action :authenticate_user!
# before_action :check_doctor_role

    def index
      if current_user.role == 'recipient'
        redirect_to receptionists_path
      else
        cr = current_user
        if cr.nil?
          @patients= nil
          return
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

    def registrations_chart
        doctor = current_user.doctor
        puts "-------------------sdsdsdsdsd-------------"
        patients = doctor.patients
        patients_by_day = patients.group_by { |patient| patient.created_at.to_date }
        patient_count_by_day = patients_by_day.transform_values(&:count)
        data = patient_count_by_day.map { |date, count| [date, count] }
        puts "Data: #{data}" # Debug statement
        @chart = LazyHighCharts::HighChart.new('graph') do |f|
          f.title(text: 'Patient Registrations')
          f.xAxis(categories: data.map { |item| item[0] })
          f.series(name: 'Registrations', yAxis: 0, data: data.map { |item| item[1] })
        end
      end
      
    
  
  
    def check_doctor_role
    unless current_user.role == 'doctor'
    redirect_to root_path
    return
    end
    end
end
