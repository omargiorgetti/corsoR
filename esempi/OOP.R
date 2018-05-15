Account <- setRefClass("Account",
                       fields = list(balance = "numeric"),
                       methods = list(
                         withdraw = function(x) {
                           balance <<- balance - x
                         },
                         deposit = function(x) {
                           balance <<- balance + x
                         }
                       )
)

NoOverdraft <- setRefClass("NoOverdraft",
                           contains = "Account",
                           methods = list(
                             withdraw = function(x) {
                               if (balance < x) stop("Not enough money")
                               balance <<- balance - x
                             }
                           )
)

accountJohn<-Account$new(balance=100)
accountJohn$balance
accountJohn$deposit(50)
accountJohn$balance
accountJohn$withdraw(75)
accountJohn$balance
str(accountJohn)

accountJohn <- NoOverdraft$new(balance = 100)
str(accountJohn)
accountJohn$deposit(50)
accountJohn$balance
accountJohn$withdraw(75)
accountJohn$balance