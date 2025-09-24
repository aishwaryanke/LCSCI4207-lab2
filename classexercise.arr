use context starter2024

fun choose-hat(temp-in-C :: Number) -> String: 
  doc: "determines apprpropriate head gear, with above 27C a sun hut, below nothing"
  if temp-in-C >= 27:
    "sun hat"
  else:
    "no hat"
  end
where:
  choose-hat(25) is "no hat"
  choose-hat(32) is "sun hat"
  choose-hat(27) is "sun hat"
end

fun mysterious-function(x) block:
  # First expression
  print("Input value is: " + num-to-string(x))
  # Conditionals also produce expressions
  if x == 0:
    1
  else if x > 0:
    x * 2
  else:
    x * -1
  end
end

fun choose-ahat(temp-in-C :: Number) -> String:
  doc: "determines appropriate headgear, with below 10C a winter hat, above nothing"
  if temp-in-C < 10:
    "winter hat"
  else if temp-in-C >= 27:
    "sun hat"
  else:
    "no hat"
  end
where: 
  choose-ahat(18) is "no hat"
  choose-ahat(5) is "winter hat"
  choose-ahat(10) is "no hat"
  choose-ahat(40) is "sun hat"
end

fun add-glasses(outfit :: String) -> String:
  doc: "takes outfit number and adds glasses to it"
  outfit + " and glasses" 
end


fun choose-outfit(temp-in-C :: Number) -> String:
  doc: "uses choose-hat and add-glasses to compute a final outfit" 
  add-glasses(choose-hat(temp-in-C))
end

fun choose-visor(temp-in-C :: Number, hasvisor :: Boolean) -> String:
  doc: "uses choose-hat and add-glasses to compute a final outfit" 
  ask:
    |(temp-in-C >= 27) and hasvisor then: "visor"
    |(temp-in-C >= 27) then: "sun hat"
    |otherwise: "no visor"
  end
where:
  choose-visor(30,true) is "visor"
  choose-visor(30,false) is "sun hat"
  choose-visor(15,false) is "no visor"
end
