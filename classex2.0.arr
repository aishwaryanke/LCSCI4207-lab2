use context dcic2024
include csv
include data-source # to get the sanitizers

blue-square = rectangle(40, 40, "solid", "blue")

radius = 10
area = 3.14 * radius * radius 

orange-triangle = triangle(35, "solid", "orange") 

lengths = 35 
color = "purple"

purple-square = square(lengths, "solid", color)
yellow-circle = circle(10, "solid", "yellow")

overlay(yellow-circle, purple-square)

3 + 5
num-min(2,8)
rotate(90, rectangle(20, 20, "solid", "red"))

overlay(circle(20, "solid", "purple"),rectangle(50, 25, "solid", "red"))

above(circle(20, "solid", "purple"),rectangle(50, 25, "solid", "red"))

purple-tri = triangle(30, "solid", "purple")
green-sqr = rectangle(60, 60, "solid", "green")

overlay(rotate(45, purple-tri),
  green-sqr)

above(purple-tri,
  overlay(rotate(45, purple-tri),
    green-sqr))
above(green-sqr, above(purple-tri,
  overlay(rotate(45, purple-tri),
      green-sqr)))
frame(
  above(rectangle(120, 30, "solid", "red"),
    above(rectangle(120, 30, "solid", "white"),
      rectangle(120, 30, "solid", "red"))))

fun moon-weight(earth-weight :: Number) -> Number:
  doc: "Compute weight on moon from weight on earth"
  earth-weight * 1/6
end

moon-weight(6
  )
fun buytickets1(count1 :: Number) -> Number:
  doc: "computes total price of movie tickets"
  count1 * 10
where:
  buytickets1(0) is 0
  buytickets1(2) is 2 * 10
  buytickets1(6) is 6 * 10
end

shuttle = table: month, riders
  row: "Jan", 1123
  row: "Feb", 1045
  row: "Mar", 1087
  row: "Apr", 999
end

shuttle.row-n(2)
shuttle.row-n(2)["riders"]

fun is-winter(r :: Row) -> Boolean:
  doc: "determines whether month in the chosen row is jan, feb or mar"
  if (r["month"] == "Jan") or (r["month"] == "Feb") or (r["month"] == "Mar"):
    true
  else:
    false
  end
where: 
  is-winter(shuttle.row-n(2)) is true
  is-winter(shuttle.row-n(1)) is true
  is-winter(shuttle.row-n(3)) is false
end

fun below-1K(r :: Row) -> Boolean:
  doc: "determine whether row has fewer than 1000 riders"
  r["riders"] < 1000
where:
  below-1K(shuttle.row-n(2)) is false
  below-1K(shuttle.row-n(3)) is true
end

filter-with(shuttle,below-1K)
filter-with(shuttle, is-winter)

order-by(shuttle, "riders", true)

url = "https://pdi.run/f25-dcic-events-orig.csv"
event-data =
  load-table: name, email, tickcount, discount, delivery, zip
    source: csv-table-url(url, default-options)
  end


cleaned-event-data =
  load-table: name, email, tickcount, discount, delivery, zip
    source: csv-table-url("https://pdi.run/f25-dcic-events-data.csv", default-options)
    sanitize name using string-sanitizer
    sanitize email using string-sanitizer
    sanitize tickcount using num-sanitizer
    sanitize discount using string-sanitizer
    sanitize delivery using string-sanitizer
    sanitize zip using string-sanitizer
  end


fun order-scale-label(r :: Row) -> String:
  doc: "categorize the number of tickets as small, medium, large"
  
  if r["tickcount"] >= 10:
    "large"
  else if r["tickcount"] >= 5:
    "medium"
  else: "small"
  end
end

order-bin-data =
  build-column(event-data, "order-scale", order-scale-label)
