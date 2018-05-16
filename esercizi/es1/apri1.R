N <- dim(X)[1]
K <- dim(X)[2]
Q <-dim(R)[1]
invXX <- solve(t(X)%*%X)		# calcolo (X'X)-1
B.st <- invXX%*%t(X)%*%Y		# stimo B^=(X'X)-1 X'Y
res <- Y - X%*%B.st			# ricavo i residui
s2.st <- c(t(res)%*%res)/(N-K)	# stimo s2
S2.st <- s2.st*invXX			# stimo S2=s2(X'X)-1
std.B <- sqrt(diag(S2.st))		# std.err dei B
t.value <- B.st/std.B
p.value <- 2*(1-pt(t.value, (N-K)))
inf <- B.st - qt(0.975, (N-K))*std.B
sup <- B.st + qt(0.975, (N-K))*std.B
ris<-cbind(B.st, std.B, inf, sup, t.value, p.value)
coeff <- round(ris, 3)
# test F sull'Ipotesi generale RB = r
if(test==1)
{
df <- c(N, K-Q, Q, N-K)
invRX <- solve(R%*%invXX%*%t(R))
SQtot <- c(t(Y)%*%Y)
SQreg <- t(B.st)%*%(t(X)%*%X)%*%B.st
SQreg.vinc <- t(R%*%B.st-r)%*%invRX%*%(R%*%B.st-r)
SQres <- c(t(res)%*%res)
SQ    <-c(SQtot, SQreg, SQreg.vinc, SQres)
MSQ   <-SQ/df
F1    <-MSQ[2]/MSQ[4]
F2    <-MSQ[3]/MSQ[4]
Fp.value1 <-1-pf(F1, K-Q, N-K)
Fp.value2 <-1-pf(F2, Q, N-K)
tab.anova<-cbind(df, SQ, MSQ, c(NA, F1, F2,NA),
c(NA, Fp.value1,Fp.value2, NA))
list(coeff, tab.anova)
}
else {coeff}
