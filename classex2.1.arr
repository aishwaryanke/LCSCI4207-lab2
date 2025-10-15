use context dcic2024
include csv

include csv
include data-source

plant = load-table:
  commonname :: String,
  locationlatitude :: Number,
  locationlongitude :: Number,
  date_sighted :: Number,
  soil_type :: String, 
  plant_height_cm :: Number,
  plant-color :: String
  
  source: csv-table-url(
      "https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
    
end

plant.row-n(4)["commonname"]
plant.row-n(4)["date_sighted"]
plant.row-n(4)["soil_type"]
plant.row-n(4)["plant-color"]

plant.length()

glucose = load-table:
  patient_id :: String, 
  glucose_level :: String,
  date_time :: Number,
  insulin_dose :: Number,
  exercise_duration :: Number,
  stress_level :: Number
  
  source: csv-table-file("glucose_levels.csv", default-options)
  
  sanitize insulin_dose using num-sanitizer
  sanitize exercise_duration using num-sanitizer
  sanitize stress_level using num-sanitizer
end
    
mean(glucose, "insulin_dose") 
median(glucose, "exercise_duration") 

lr-plot(glucose, "stress_level", "insulin_dose") 
