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

#Concrete Exampleson document
#Converting body mass: Divide grams by 1000 to get kilograms

# Function to convert body mass from grams to kilograms
fun grams-to-kg(grams :: Number) -> Number:
  doc: "Convert a penguin's body mass from grams to kg"
  grams / 1000
end

fun transform-to-kg(species-name :: String) -> List<Number>:
  doc: "Get body masses in kg for specific species"
  #Filter for the specified species
  species-penguins = filter-with(penguines-table, 
    lam(row): row["species"] == species-name end)
   
  body-masses-grams = species-penguins.column("body-mass")
  
  #Tranform each row using map
  map(grams-to-kg, body-masses-grams)
where: #Testing with examples
  grams-to-kg(3750) is-roughly 3.75
  grams-to-kg(1000) is-roughly 1.0
end

#Selection
#Question: Which penguins are "extreme athletes" meaning in the top 10% for both flipper length and body mass within their species?
#Input: Full penguin dataset
#Output: A filtered subset conataining only the elite penguins who excel in both measurements

#filtering the dataset to eep only rows that meet multiple criteria simulaneously 

#Exampls in google docs

fun extreme-species(species :: String) -> Table:
  doc: "Find penguins in the top 10% (strongest & longest) for flipper length AND body mass"
  
  #Get penguins of the species
  species1 = penguines-table.filter(
    lam(row): row["species"] == species end)
  
  #Getting flipper lengths and finding the 90th percentile
  flippers = species1.column("flipper-length")
  sorted-flippers = sort(flippers)
  flipper-cutoff = sorted-flippers.get(num-floor(0.9 * length(sorted-flippers)))

  #Getting body masses and finding the 90th percentile
  masses = species1.column("body-mass")
  sorted-masses = sort(masses)
  mass-cutoff = sorted-masses.get(num-floor(0.9 * length(sorted-masses)))
      
      #keeping only penguins with both cutoffs
  species1.filter(
        lam(row):
          (row["flipper-length"] >= flipper-cutoff) and
          (row["body-mass"] >= mass-cutoff)
        end)
      where:
  extreme-species("Adelie").length() > 0 is true
  extreme-species("Adelie").length() > 6 is false
  extreme-species("Gentoo").length() < 3 is false
    end
extreme-species("Adelie")
extreme-species("Gentoo")

#Using the function and one of the species, extreme-species("Adelie"), it will return a table with all the values in the 10%. The examples just test how many species are in the 10% for each species.

#Accumulation
#Question: What are the lightest and heaviest penguins for a specific species, found in a single pass through the data?
#Input: Penguin table filtered by species
#Output: A record containing both the minimum nd maximum body mass like {min: 2850, max: 4775}



fun min-max-mass(species-name :: String) -> {min :: Number, max :: Number}:
  doc: "Finds the lightest and heaving penguin for a species"
  
  #Filter for specified species
  species-penguins = penguines-table.filter(
    lam(row): row["species"] == species-name end)
  
  #Getting all the body masses
  masses = species-penguins.column("body-mass")
  #Accamulating both min and max at the same time, starting with exxagerated values that will definetely be replaced
  result = fold(
  lam(acc, mass):
    {
      min: if mass < acc.min: mass
            else: acc.min end,
      max: if mass > acc.max: mass
            else: acc.max end
    }
  end,
  {min: 999999, max: 0},
  masses)

  result
 where:
  # Testing with Adelie penguins
  adelie-range = min-max-mass("Adelie")
  adelie-range.min < adelie-range.max is true
  adelie-range.min > 0 is true
  adelie-range.max < 999999 is true
end

# Ran it to see the results
min-max-mass("Adelie")
min-max-mass("Gentoo")
min-max-mass("Chinstrap")