(1..50).each do |i|
    Patient.create(name: "P#{i}" , age: 13+i , doctor_id: 6 , user_id: 12 , gender: "male" ,created_at: Time.now - i.days, updated_at: Time.now - i.days)
end