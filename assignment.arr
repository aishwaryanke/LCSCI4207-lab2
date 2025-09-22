import file("lab2-support.arr") as support

#| ENCRYPTORS |#

fun my-encryptor1(input :: String) -> String:
  string-repeat(input,5)
end
support.test-encryptor1(my-encryptor1)

fun my-encryptor2(input :: String) -> String:
  string-repeat(input,5)
end
support.test-encryptor2(my-encryptor2)

fun my-encryptor3(input :: String) -> String:
  string-substring("input", 0, 1)
end
support.test-encryptor3(my-encryptor3)

fun my-encryptor4(input :: String) -> String:
  string-repeat(input,4)
end
support.test-encryptor2(my-encryptor4)

fun my-encryptor5(input :: String) -> String:
  string-repeat(input,4)
end
support.test-encryptor5(my-encryptor5)

fun my-encryptor6(input :: String) -> String:
  string-repeat(input,4)
end
support.test-encryptor6(my-encryptor6)


fun my-encryptor7(input :: String) -> String:
  string-repeat(input,4)
end
support.test-encryptor7(my-encryptor7)


#| TEST ENCRYPTORS |#

support.encryptor1("hello")

support.encryptor2("bo-0m")

support.encryptor3("H3AH3Ah")

support.encryptor4("yallarebADDDD")

support.encryptor5("BOAH BOAH BOAH")

support.encryptor6("BOAH BOAH BOAH")

support.encryptor7("BOAH BOAH BOAH")


