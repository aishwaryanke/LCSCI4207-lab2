use context dcic2024
include csv
orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end

fun is-morning(o :: Row) -> Boolean:
  o["time"] < "12:00"
where: 
  is-morning(orders.row-n(1)) is true 
  is-morning(orders.row-n(5)) is false
end


new-high-orders = filter-with(orders, is-morning)

filter-with(orders, lam(o): o["time"] < "12:00" end )

order-by(orders, "time", false)

place = load-table:
  location :: String, 
  subject :: String, 
  date :: Number
  
  source: csv-table-url( "https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/photos.csv", default-options)
    
end

filter-with(place, lam(o): o["subject"] == "Forest" end )


count(place, "date")

freq-bar-chart(place, "location") 