use context dcic2024
data Temperature:
  | celcius(degrees :: Number)
  | fahrenheit(degrees :: Number)
  | kelvin(degrees :: Number)
end

fun to-celcius(t :: Temperature) -> Number:
  cases (Temperature) t:
    |celcius(d) => d
    |fahrenheit(d) => (5/9) * (d - 32) 
    | kelvin(d) => d - 273.15
  end
  
where:
  body-temp = fahrenheit(100)
  to-celcius(body-temp) is%(within-abs(0.1)) 37.7
end
  
data Status:
  | todo
  | in-progress
  | done
end
    
data Task:
  | task(description :: String, 
      priority :: Priority,
      status :: Status)
  | note(decription :: String)
end 

data Priority:
  | low
  | medium
  | high
end

task-1 = task("Buy Groceries", low, todo)
task-2 = task("Pay council tax", low, in-progress)
note-1 = note("Post Office closes at 4:30")

tasks = [list: task-1, task-2, note-1]

fun priority-to-string(p :: Priority) ->
  String: cases (Priority) p:
    | low => "❕TASK:"
    | medium => "❗️TASK:"
    | high => "‼️ TASK:"
  end 
end

fun status-to-string(s :: Status) -> String:
  cases (Status) s:
    | todo => "To-Do"
    | in-progress => "In-Progress"
    | done => "Done"
  end
end

fun describe(t :: Task) -> String:
  cases (Task) t:
    | task(d, p, s) => status-to-string(s) + priority-to-string(p) + " " + d
    | note(d) => "📝 " + d
  end
end


data Weatherreport:
  | sunny(temperature :: Number)
  | rainy(temperature :: Number, precipitation :: Number)
  | snowy(degrees :: Number, precipitation :: Number, wind-speed :: Number)
end
weather = rainy(20,30)

fun is-severe(w :: Weatherreport) -> Boolean:
  cases (Weatherreport) w:
    |sunny(t) => (t > 35) 
    | rainy(t, p) => (p > 20) 
    | snowy(t, p, ws) => (ws > 30)
  end
end

