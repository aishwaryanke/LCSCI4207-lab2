use context dcic2024

include csv
include data-source # for the sanitizers

# Loading the data 
penguines-table = 
  load-table: row-index, species, island, bill-length, bill-depth, flipper-length, body-mass,
  sex, year
    source: csv-table-file("penguins.csv", default-options)
    sanitize species using string-sanitizer
    sanitize island using string-sanitizer
    sanitize bill-length using num-sanitizer
    sanitize bill-depth using num-sanitizer
    sanitize flipper-length using num-sanitizer
    sanitize body-mass using num-sanitizer
    sanitize sex using string-sanitizer
    sanitize year using num-sanitizer
  end
#Scalar processing, Question: What is the average body mass of Adelie penguins?
#Function to calculate average body mass for a given species
fun average-body-mass-by-species(species-name :: String) -> Number:
  doc: "Calculate the average body mass for penguins of a given species"
  species-penguins = filter-with(penguines-table, 
    lam(row): row["species"] == species-name end)
  body-masses = species-penguins.column("body-mass")
  total-mass = fold(lam(mass, acc): mass + acc end, 0, body-masses)
  total-mass / (length(body-masses))
  where:
  average-body-mass-by-species("Adelie") is-roughly 3706.16438356
  average-body-mass-by-species("Gentoo") is-roughly 5092.436974789915966386554621848739495798319327731092   # run to get actual value
  average-body-mass-by-species("Chinstrap") is-roughly 3733.08823529411764705  # run to get actual value
end


adelie-avg = average-body-mass-by-species("Adelie")
gentoo-avg = average-body-mass-by-species("Gentoo")
chinstrap-avg = average-body-mass-by-species("Chinstrap")

#Transformations
#Problem analysis, Question: How can we convert all penguin body masses from grams to kilograms for easier interpretation?
#Input: A list of penguin rows with body mass in grams
#Output: A list of penguin rows where body mass is now in kilograms
#Why is this transformation?: Taking each penguin record and creating a modified version with a converted measurment. The list stays the same length, one transformed penguin for each original penguin.

#Concrete Examples:
#Penguin 1: Adelie, body_mass = 3750g
#Penguin 2: Adelie, body_mass = 3800
#Penguin 3: Adelie, body_mass = 3750g

#Converting body mass: Divide grams by 1000 to get kilograms
# Function to convert body mass from grams to kilograms
fun body-mass-to-kg(penguin-row) -> Row:
  doc: "Convert a penguin's body mass from grams to kg"
  penguin-row.update("body-mass", penguin-row["body-mass"] / 1000)
end

fun transform-to-kilograms(species-name :: String) -> Table:
  doc: "Transform all penguins of a given species to have body mass in kg"
  #Filter for the specified species
  species-penguins = filter-with(penguines-table, 
    lam(row): row["species"] == species-name end)
  #Tranform each row using map 
  transformed-rows = map(body-mass-to-kg, species-penguins.allrows())
  transformed-rows
where: #Testing with examples
  test-penguin = penguines-table.row-n(0)
  transformed = body-mass-to-kg(test-penguin)
  transformed["body-mass"] is-roughly (test-penguin["body mass"] / 1000)
end
  