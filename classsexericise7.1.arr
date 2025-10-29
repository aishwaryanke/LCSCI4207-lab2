use context dcic2024

fun my-pos-nums(l):
  cases (List) l:
    | empty => empty 
    | link(f,r) =>
      if f > 0:
        link(f, my-pos-nums(r))
      else:
        my-pos-nums(r)
      end
  end
end

fun my-alternating(l):
  cases (List) l:
    |empty => empty
    | link(f,r) =>
      cases (List) r: # note: deconstructing r, not l
        | empty => [list: f]
        | link(fr, rr) => link(f, my-alternating(rr))
        end
  end
where:
  my-alternating([list: 1, 2, 3, 4, 5, 6]) is [list: 1, 3, 5]
end

#Class Exercise: Selection
fun more-than-five(l :: List<String>) -> List<String>: 
  doc: "Returns list with only strings longer than 5 characters"
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if string-length(f) > 5:
        link(f, more-than-five(r))
      else:
        more-than-five(r)
      end
  end
where:
  more-than-five([list: "hii", "ohmy", "imscared"]) is [list: "imscared"]
  more-than-five([list: "no", "bye"]) is empty
  more-than-five([list: "rawr", "cutiepie", "ihateyou"]) is [list: "cutiepie", "ihateyou"]
end

#Relaxed Domains
fun my-len(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
where:
  my-len([list: 7, 8, 9]) is 3
end 

fun my-sum(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => f + my-sum(r)
  end
where:
  my-sum([list: 7, 8, 9]) is 24
end

fun my-average(l): 
  cases (List) l:
    | empty => raise("Cannot average an empty list")
    | else => my-sum(l) / my-len(l)
  end 
where:
  my-average([list: 7, 8, 9]) is 8
  my-average([list: 1, 3, 8]) is 4
end 
      

#Class Exercise: Accumultors
#Defining a my-max function 
fun my-max(l):
    cases (List) l:
      | empty => empty
      | link(f, r) => m-m1(f, l)
    end
end

fun m-m1(biggest-number-encountered, l):
  cases (List) l:
    | empty => biggest-number-encountered
    | link(f, r) =>
      if f > biggest-number-encountered: m-m1(f,r)
      else: 
        m-m1(biggest-number-encountered, r)
      end
  end
where:
  my-max([list: 4, 5, 3]) is 5
  my-max([list: 0, 0, 0]) is 0
  my-max([list: -2, -4, -1]) is -1
end 

#Defining a my-alternating function
fun my-alternating1(l):
  my-a1(true, l)
  where:
  my-alternating([list: 1, 2, 3, 4, 5, 6]) is [list: 1, 3, 5] 
end

fun my-a1(keep, l):
  cases (List) l:
    | empty => empty 
    | link(f, r) =>
      ask:
        | keep then: link(f, my-a1(false, r))
        | otherwise: my-a1(true, r)
      end
  end
where:
  my-alternating([list: 2, 3, 4, 5, 6]) is [list: 2, 4, 6]
  my-alternating([list: 1]) is [list: 1]
  my-alternating(empty) is empty
end




      
