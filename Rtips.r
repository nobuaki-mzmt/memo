## R functions
## N.Mizumoto
## 19/06/14 updated

####################
###### System ######
####################

## Check R version
sessionInfo()

## Update R
library(installr)  
updateR()

## Get today's date
today <- Sys.Date()

## stop loop even with warnings
options(warn=2)
# options(warn=0)


## Install all packages
install.packages(available.packages()[,1])

## housekeeping
  rm(list = ls())

## comment out multiple lines
if(FALSE){ 
}

## Project Path
{
  RPROJ <- list(PROJHOME = normalizePath(getwd()))
  attach(RPROJ)
  rm(RPROJ)
}

## Interactive or waiting
x <- readline("Enter to continue")


######################
###### Directry ######
######################

## Home Path make
{
  RPROJ <- list(PROJHOME = normalizePath(getwd()))
  attach(RPROJ)
  rm(RPROJ)
}

## object list
objects()

## current directry
getwd()

## create directry
dir.create(file.path(), showWarnings = FALSE)

######################################
###### Random number generation ######
######################################

## Uniform distribution (0-1)
runif(1000,0,1)

## wrapped Cauchy distribution
library("CircStats")
N = 1000; Mu = 0; Rho = 0.8;
rwrpcauchy(N, Mu, Rho)

## Power law distribution
# r: uniform distribution(0-1), a: exponent (1<a<=3)
PL <- function(r,a,xmin){
  return(xmin*(1-r)^(-1/(a-1)))
}

## Stretched exponention
# r (0-1)
SE <- function(r, lambda, beta, xmin){
  return( (xmin^beta - 1/lambda*log(1-r)  )^(1/beta))
}

## Truncated Pareto
# r: 0-1, a: exponent(1<a<=3)
TPareto <- function(r,a,xmin,xmax){
  return(xmin*((1-r)*(1-(xmax/xmin)^(1-a))+(xmax/xmin)^(1-a))^(1/(1-a)))
}

## Truncated power-law
# r: 0-1
TP <- function(r,myu,xmin,xmax){
	return( ( xmax^(1-myu) - (1-r)*(xmax^(1-myu)-xmin^(1-myu) ) )^(1/(1-myu)) )
}




############################
###### Color pallet ########
############################

# »”™‰»
cols = colorRampPalette(c("#dec67c","#b3b963","#99a256" ,"#789351","#133e27"))

# ”’‚ð‹²‚ñ‚¾Â‚©‚çÔ (F”–‚ß)
cols = colorRampPalette(c("#2166AC", "#4393C3", "#92C5DE", "#FFFFFF", "#F4A582", "#D6604D", "#B2182B"))

# ”’‚ð‹²‚ñ‚¾Â‚©‚çÔ (F”Z‚¢‚ß) Žg—p—á: RTV, Homosexual(Anim Behav), Perce search
cols = colorRampPalette(c("#053061", "#2166AC", "#4393C3", "#92C5DE", "#FFFFFF", "#F4A582", "#D6604D", "#B2182B", "#67001F"))

# ŒÀ‚è‚È‚­•‚É‹ß‚¢ƒOƒŒ[‚Ì—á
grey2 <- "#545454"

# “§‰ßF (Transparent color)
# 1
rgb(0, 0, 0, alpha=touka)
rgb(0/255, 0/255, 0/255, alpha=touka/255, maxColorValue=255)
# 2
adjustcolor(good.4.col[i], 0.5)

# Universal design
# red 			#ff2800
# yellow 		#faf500
# green			#35a16b
# blue			#0041ff
# skyblue 		#66ccff
# pink 			#ff99a0
# orange 		#ff9900
# purple 		#9a0079
# brown			#663300
# light pink 	#ffd1d1
# cream 		#ffff99
# light green 	#cbf266
# light slyblue #b4ebfa
# beju 			#edc58f
# light green 	#87e7b0
# light purple	#c7b2de

# Transparent red and blue
c(adjustcolor(c("#2166AC", "#B2182B"), 0.5))

############################
###### ƒf[ƒ^“Ç‚Ý‘‚« ######
############################

## file‚ÌêŠÝ’è‚µ‚Ä“Ç‚Ýž‚Ý
setwd("E:\\Dropbox\\research\\")
Folder.path <- getwd()
f.namesplace <- list.files(Folder.path, pattern=".csv",full.names=T)

## ‚‘¬“Ç‚Ýž‚Ý—pŠÖ”i‘å—e—Êƒf[ƒ^Œü‚¯j
library(data.table)
d <- data.frame(as.matrix(fread(data.path, header=T))) # matrix‚É•ÏŠ·‚µ‚Ä‚©‚çdata.frame‰»‚·‚é‚ÆŽg‚¢‚â‚·‚¢

## Output table
write.table(res2, "E:\\res2.txt", quote=F, sep=",", row.names=F)

## Output PDF
pdf(paste(data.path,".pdf",sep=""))
plot()
dev.off()

##########################
###### ƒxƒNƒgƒ‹‘€ì ######
##########################

## ƒxƒNƒgƒ‹“à‚Ìd•¡‚µ‚½’l‚ðŽæ‚èœ‚­i”Žš—v‘f‚ª‰½‚ª‚ ‚é‚©‚í‚©‚éj
data <- c(0,0,0,0,1,1,1,1,2,2,3,3,4)
unique(data)
# [1] 0 1 2 3 4

## Œ‡‘¹’l‚ð–³Ž‹‚µ‚ÄŒvŽZ‚·‚é
x <- c(1, 2, 3, 4, NA, NaN)
sum(x, na.rm = TRUE)

## ˜_—Œ^ƒxƒNƒgƒ‹‚Ì’†g‚ÌŠm”F
x <- c(TRUE, TRUE, FALSE)
any(x) # ‚Ç‚ê‚©‚P‚Â‚Å‚àTRUE‚©H
# [1] TRUE
all(x) # ‘S‚ÄTRUE‚©H
# [1] FALSE

## T/F ƒxƒNƒgƒ‹‚ÌT‚Ì‰ò‚Ìƒ‰ƒxƒ‹•t‚¯
tandem_label <- rep(0,L)
count <- 1
for(i in 1:L){
  if(tandem[i]){
    tandem_label[i] <- count
  } else if(i>1&&tandem[i-1]) {
    count <- count + 1
  }
}

## •ªŠ„•\‚Ìì¬, Generating Contingency table
xtabs(~accb0+accb1, data=d)

## —ÝÏ˜a‚ÌŒvŽZ calcurate Cumulative sum
cumsum()

## R‚Ì2‚Â‚Ì•¶ŽšƒxƒNƒgƒ‹‚ð”äŠr‚µ‚Ü‚·
# A ‚©‚Â B ‚É‚ ‚é‚â‚Â
A %in% B
# A‚É‚ ‚é‚ªB‚É‚È‚¢‚â‚Â
setdiff(A,B)

##############################
###### Matrix operation ######
##############################

## row‚ð”½“]iimage.plot‚ÌÛ‚Ìã‰º”½“]‚É‘Î‰žj
dhis <- t(apply(dhis,1,rev))

## ‘ÎŠp¬•ª‚ðŽæ“¾
diag(mat)

## Obtain Inverse matrix (‹ts—ñ‚ÌŽæ“¾)
solve(mat)

## Matrix maltiplication (s—ñ‚Ìæ–@)
mat1 %*% mat2

############################
###### Aray operation ######
############################

## apply function
apply(interaction.mat, c(1,2), any)
apply(interaction.mat, c(1,3), any)
apply(interaction.mat, c(2,3), any)



######################
##### Data frame #####
######################

## obtain mean, sd. se
data_summrize <- function(d, variable, cname){
	se  <-  function(x){
	  y  <-  x[!is.na(x)]  #  remove  the  missing  values
	  sqrt(var(as.vector(y))/length(y))
	}
	l <- length(cname)
	if(l>=2){
	  df <- data.frame(as.vector(tapply(d[,cname][,1], d[,cname], unique)))
	  for(i in 2:l){
	    df <- data.frame(df,
	                     as.vector(tapply(d[,cname][,i], d[,cname], unique))
	    )
	  }
	} else {
	  df <- data.frame(as.vector(tapply(d[,cname], d[,cname], unique)))
	}
	df <- data.frame(df,
	                 as.vector(tapply(d[,variable], d[,cname], mean)),
	                 as.vector(tapply(d[,variable], d[,cname], sd)),
	                 as.vector(tapply(d[,variable], d[,cname], se)))
	colnames(df) <- c(cname, paste0(variable, ".", c("mean", "sd", "se")))
	return(df)
}
  
##########################
###### •¶Žš—ñ‘€ì ######## Character
##########################

## ˆê•”‚Ì•¶Žšƒpƒ^[ƒ“‚ð’uŠ·
gsub(".csv", "-ready.csv", f.namesplace[i])

## ƒtƒ@ƒCƒ‹“Ç‚Ýž‚Ýˆê—á i‚ ‚é•¶Žš—ñ‚ðŠÜ‚Þƒf[ƒ^‚Ì‚Ý’T‚·j
setwd("E:\\Dropbox\\research\\")
Folder.path <- getwd()
f.namesplace <- list.files(Folder.path, pattern=".csv",full.names=T)
data.path <- f.namesplace[regexpr("ramuda1000_",f.namesplace)>0]

## •¶Žš—ñ‚Ìˆê•”‚ðØ‚è”²‚«
substr(f.names, 0, 8)	# from 0 to 8

## good package
library(stringr)
# example: https://heavywatal.github.io/rstats/stringr.html

## length of character
str_length(label[i])

## pattern match
str_locate(string, "a")

## cut
str_sub(string, start=1, end=5)

## count
str_count(string, pattern)

## replace
str_replace(string, "from", "to")

#####################
###### plot #########
####################

## Ž²‚ð0‚©‚ç10‚Ü‚Å‚É‚«‚Á‚¿‚è‚·‚é
plot(x,y, xlim=c(0,10)m ylim=c(0,10), xaxs = "i", yaxs = "i")

## abline
abline(a, b)  # a‚ÍØ•Ð, b‚ÍŒX‚«
abline(h = y) # y = h
abline(v = x) # x = v

## –_ƒOƒ‰ƒt‚ÌŽ²‚Ì‚Â‚¯•û
Fig <- barplot(Means, beside=T)
arrows(Fig, Means, Fig, Means+SE)

## barplot with two different factors
DataMean <- tapply(ds$PC1, ds[,2:3], mean)
DataSe <- tapply(ds$PC1, ds[,2:3], se)
fugo <- DataMean / abs(DataMean)
XonFig <- barplot(DataMean, beside=T, ylim=c(-8,4))
arrows(XonFig , DataMean, XonFig , DataMean+ fugo*DataSe, angle=90, length=0.1)

## Heatmap with dendrogram
library(gplots)
heatmap.2(as.matrix(scale(d)), Rowv = T, Colv=T, distfun = dist, hclustfun = function(d) hclust(d, method="ward.D")
          , dendrogram = c("row"), trace="none", col=cols)

## 3D, scatter plot 1; 3ŽŸŒ³ŽU•z} 1
library(scatterplot3d)
scatterplot3d(x,y,z, type="o")

## 3ŽŸŒ³ŽU•z} 2
library("plot3D")
scatter3D(d$Length, d$M12FW, d$Maxspeed, bty = "g", pch = as.numeric(d$caste),
          col = ramp.col(c("blue", "yellow", "red")), theta = 180, phi = 90 )
          
## ‰~‚ð•`‚­
theta <- seq(-pi, pi, length=100)
points(cos(theta)*50+50, sin(theta)*50+50, type="l")

## Histogram
geom_histogram(binwidth = 1, col=1)

## 2D histrgram-1
library(gplots)
h2 <- hist2d(cbind(x,y), nbins=c(40,40), xlim=c(-20,20), ylim=c(-20,20), col=cols1(10))

## 2D histrgram-2
library(hexbin)
h <- hexbin(d[,1:2])
plot(h)

## legend
legend(x=-10, y=-7.5, legend=c("Move forward", "Excavation", "Backing", "Waiting"), col=c("red","green","blue","orange"), pch=19)


## create gif animation
library("animation")
library("jpeg")
library("tcltk")
saveGIF(expr={ plot() }, interval = 0.1, movie.name = "E:TEST.gif", loop=1) 


#######################
###### ggplot #########
#######################
library(ggplot2)
library(gridExtra)

#### main
p <- ggplot(data=df, aes(x=x,y=y,colour=as.factor(ind))))

#### quick plot
qplot(x=, y=, ymin=, ymax=, data=df, ylim=c(0,1), geom = "pointrange") ## arrow

#### plot type

### Comparison

## scatter plot
+ geom_point()
geom_jitter(width=0.1) #‚Î‚ç‚Â‚©‚¹‚½‚¢‚Æ‚«

## barplot + errorbar
geom_bar(stat="identity", width = 1, col="black", bg="black")
geom_errorbar(aes(ymin=BackCountMean-BackCountMeanSE, ymax=BackCountMean+BackCountMeanSE), width=0.1)

## violin plot
geom_violin(alpha=0.5, aes(fill=TimeSpan), draw_quantiles = c(0.5))
 
## dot plot
geom_dotplot(binaxis='y', stackdir='center', dotsize=0.7, binwidth=0.02)+


## trajectories
+ geom_path()

## 2d histgram or density
# 1
p + stat_bin2d(bins=c(30,15)) + scale_fill_gradientn(colours=cols1(10))	

# 2
stat_density2d(aes(fill = stat(level)), geom = "polygon") 

# 3
require(hexbin) 
stat_bin_hex(bins=50) 

## smoothing
stat_smooth(se=T)

## heatmap
geom_tile(aes(fill = sleeptime), color="black") + scale_fill_gradientn(name="Feeding time (min)", colours = (cols(20)))

#---------------------------------------------------------------------------------------------------------------------------#
# multiple density plot
#---------------------------------------------------------------------------------------------------------------------------#
library(ggridges)
geom_density_ridges(fill=2, stat = "binline", binwidth=1, alpha=0.2, draw_baseline = T)
#---------------------------------------------------------------------------------------------------------------------------#

## abline
# vertical line
p + geom_vline(xintercept = 0, color = "black", size=1.5)
# horizontal line
p + geom_hline(yintercept = 0, color = "black", size=0.5)


## statics
# point, mean +- se (standard error)
posn.d <- position_dodge(width = 0.5) # ‚¸‚ç‚·‚Ì‚É•K—v
stat_summary(geom = 'errorbar', position = posn.d, fun.data = mean_se, width=0.25)
stat_summary(geom = 'point', position = posn.d, fun.y = mean, size = 3)
# 


#### fecet
## divide into multiple figures
p + facet_grid(hour~colony + rep)

# change the label
week_labs <- c("1-20", "21-40", "41-60", "61-80", "81-100")
names(week_labs) <- c(0:4)
p + facet_grid(weekday ~ week, labeller = labeller(week=week_labs))

# facet_wrap‚Å—ñsŽw’è
p + facet_wrap(~period, ncol=4)

# facet label‚Ì•ÒW
facet_wrap(~hour, nrow=6, ncol=3, labeller = label_both) # combining the name of the grouping variable with group levels
+ theme(strip.background = element_rect(colour="#00000000", fill="#00000000")) # ‘S‚Ä“§–¾‚É

#### design ####
## tits of axis
p + scale_y_continuous(breaks=c(0,60))

## title
p + ggtitle("Reticuli")

## adjust aspect
p + coord_fixed() 

## black frame, white background and grey grid
p + theme_bw()

## lengthen tick marks
p + theme(axis.ticks = element_line(colour = "black"), axis.ticks.length = unit(0.5, "cm")) 

## aspect ratio in graph panel
p + theme(aspect.ratio=1)

## ‘S‚Ä‚Ì–}—á‚ðÁ‚·
p + theme(legend.position = 'none')

## legend ‚ÌˆÊ’u
theme(legend.position = "top", aspect.ratio=2) 

## legend position
theme(legend.position = c(0.6, 0.8)) 

#### Ž²ŠÖ˜A axis
## limit
p + xlim(-220, 220) + ylim(-120, 40) 

## xŽ²‚ÆyŽ²‚ð“ü‚ê‘Ö‚¦‚é
p + coord_flip()

## Ž²‚ð‚È‚­‚·
p + theme(axis.title.x = element_blank())

## Ž²‚Ìtick label‚Ì•ÏX
scale_y_discrete(breaks=c("0","10","20","30","40"), labels=c("0-10", "10-20", "20-30", "30-40", "40-50"))

## Ž²‚Ì”ÍˆÍ‚Ì—]”’‚ð‚È‚­‚·
scale_x_continuous(expand = c(0, 0))

## Ž²‚Ì”Žš‚ð‹t‡‚É‚·‚é
scale_y_reverse(expand = c(0, 0)) 

## Rotate label
theme(axis.text.x = element_text(angle = 30, hjust = 1))

#### save data
ggsave("181023_Density.png")	
ggsave("BackDis.pdf", width = 8, height = 4)


#######################
##### Calcuration #####
#######################

# round up (10‚ÌŒ…‚ÅØ‚èã‚°)
roundUp <- function(x) 10^ceiling(log10(x))

# Šp“x‚ÌŒvŽZ Angle calcuration
angle_cal <- function(X, Y, L){
  Ax <- (X[3:L2-1] - X[3:L2-2])
  Bx <- (X[3:L2] - X[3:L2-1])
  Ay <- (Y[3:L2-1] - Y[3:L2-2])
  By <- (Y[3:L2] - Y[3:L2-1])
  hugo <- (Ax * By - Ay * Bx + 0.000001)/abs(Ax * By - Ay * Bx + 0.000001)
  cos <- round((Ax * Bx + Ay * By) / ((Ax^2 + Ay^2)*(Bx^2 + By^2))^0.5,14)
  return(acos(cos)*hugo)
}

# ƒxƒNƒgƒ‹‚Ì‚È‚·Šp (angle between two vectors)
angle_cal_vectors <- function(X1,Y1,X2,Y2){
	acos( (X1*X2 + Y1*Y2) / ( sqrt(X1^2+Y1^2) * sqrt(X2^2+Y2^2) ) )
}

# atan (arctangent)
atan(y/x) # -pi/2 ~ pi/2
atan2(y,x) # -pi ~ pi

#### transformation #####
## logit transformation
log(y/(1-y))

###################################
###### Statistical analysis #######
###################################

##### Index #####

## Standard Error
se  <-  function(x){
  y  <-  x[!is.na(x)]  #  remove  the  missing  values
  sqrt(var(as.vector(y))/length(y))
}

## Binomial confident interbal
binom.confint(x=kick, n=jaw+kick, methods="wilson")

## Morishita's Idelta Index‚ÌŒvŽZ
Idelta <- function(x){
  return(length(x)*sum(x*(x-1)) / ( sum(x) * (sum(x)-1) ))
}

## Gini coeficient
install.packages("ineq")
library(ineq)
ineq(x, type="Gini") # x: vector with values of each individual
plot(Lc(dd[1,])) # write a Lorenz curve

## Chi-square periodgram
d <- read.table("clipboard",header=T)
Analysis <- d[,2]

P = Qp1per = Qp = rep(0,239)
for(j in 2:240){
  da <- Analysis
  P[j-1] <- j
  rhythm.tab <- matrix(da,ncol=P[j-1],byrow=T)
  y <- rep(0,P[j-1])
  for(i in 1:P[j-1]){
    y[i] <- mean(rhythm.tab[,i])
  }
  K <- length(rhythm.tab[,1])
  N <- length(da)
  xmean <- mean(da)
  
  Qp[j-1] <- K*N*sum((y - xmean)^2) / sum((da-xmean)^2)
  Qp1per[j-1] <- qchisq(0.99, P[j-1]-1)
}
res <- data.frame(P = P, Qp1per = Qp1per, Qp = Qp)

P[(Qp-Qp1per) == max(Qp-Qp1per)]/240

par(pin=c(4,3))
plot(P/240,Qp, type="l", xlab="time (second)")
points(P/240,Qp1per, type="l", col=2)




##### Distribution test #####

## ³‹K«‚ÌŒŸ’è
shapiro.test(x)

## ƒKƒ“ƒ}•ª•z
ge <- fitdistr(d[,i], "gamma", list(shape = 1, rate = 0.1), lower = 0.001)
ks.test(x, "pgamma", ge$estimate[1], ge$estimate[2], alternative = "two.sided")


##### Cumulative Distribution Function (CDF) #####

## Truncated power-law
TP_CDF <- function(myu, x, xmin, xmax){
	(xmin^(1-myu)-x^(1-myu)) / (xmin^(1-myu)-xmax^(1-myu))
}

## Stretched Exponential
SE_CDF <- function(lambda, beta, x, xmin){
	1-exp(-lambda*(x^beta-xmin^beta))
}


##### Log Likelihood fuction #####

## Truncated Power-Law
# param = myu
TP_LLF <- function(param, data, xmin, xmax){
  length(data)*(log(param-1)-log(xmin^(1-param)-xmax^(1-param))) - param*sum(log(data))
} 

## Stretched exponential
# (param[1] = Beta, param[2]= lambda)
SE_LLF <- function(param, data, xmin){
  length(data)*log(param[1])+length(data)*log(param[2])+(param[1]-1)*sum(log(data))-param[2]*sum(data^param[1]-xmin^param[1])
}

## Truncated Power-Law (for binned dataset)
# param = myu
TP_bin_LLF <- function(param, data, xmin, xmax){
  j = 1:(max(data)/0.2)
  dj <- j
  for(i in j){
    dj[i] = sum(round(data*5) == i)
  }
  return(-length(data)*log(xmin^(1-param)-xmax^(1-param)) +sum(dj*log( (xmin+(j-1)*0.2)^(1-param) - (xmin+j*0.2)^(1-param) )))
} 

## Stretched exponential (for binned dataset)
# (param[1] = Beta, param[2]= lambda)
SE_bin_LLF <- function(param, data, xmin){
  j = 1:(max(data)/0.2)
  dj <- j
  for(i in 1:length(j)){
    dj[i] = sum(round(data*5) == i)
  }
  return( length(data)*param[2]*xmin^param[1] + sum( dj*log( exp(-param[2]*(xmin+(j-1)*0.2)^param[1]) - exp(-param[2]*(xmin+j*0.2)^param[1]) ) ) )
} 

# ‘Î”–Þ“xŠÖ” for power law
PL_llh <- function(x,xmin,a){
  n <- length(x)
  return(n*log(a-1)+n*(a-1)*log(xmin)-a*sum(log(x)))
}

# ‘Î”–Þ“xŠÖ” for power law
EXP_llh <- function(x,xmin,a){
  n <- length(x)
  return(n*(log(a)+a*xmin)-a*sum(x))
}

###### Maximum Likelihood Estimation (MLE) #####
## Exponential
Exp_MLE <- function(x, xmin){
  return(length(x)*(sum(x-xmin)^(-1)))
}

## Power-Law
PL_MLE <- function(x, xmin){
  return(1+length(x)*(sum(log(x/xmin)))^(-1))
}

## Stretched exponential (using optim function)
optim(c(0.1,0.1), SE_LLF, data=Stop_sec, control = list(fnscale = -1), method="Nelder-Mead")

## Truncated Power-Law (using optimize function)
optimize(TP_LLF, interval=c(0,6), data=Move_sec, xmin=min_sec, xmax=max_sec_M, maximum=T)



##### Non parametric #####

## Exact Binomial Test (“ñ€ŒŸ’è)
binom.test(c(a,b), p=0.5, alternative="two.side")

## Chi-squared test (ƒJƒC“ñæŒŸ’è)
chisq.test(c(a,b,c,d), p=c(4,3,2,1)/10)
chisq.test(matrix(c(20, 15, 16, 9), ncol=2, byrow=T))

## Fisher's Exact Test
fisher.test(xd)	# default
fisher.test(xd, workspace=1000000)	# indicate workspace (for large table)
fisher.test(xd,simulate.p.value=TRUE,B=1e7)	# monte carlo simulation (for very large table)

## ƒEƒBƒ‹ƒRƒNƒ\ƒ“‚Ì‡ˆÊ˜aŒŸ’è (2ŒQŠÔ‚É‘Î‰ž‚Ì–³‚¢ê‡)
library(exactRankTests)
wilcox.exact(x = vx, y = vy, paired=F)
wilcox.exact(dis ~ sex, data=d, paired=F)
#¦ wilcox.test‚Íƒ^ƒC‚ª‚ ‚é‚Æ‚«‚É‚Í³Šm‚È’l‚ð•Ô‚³‚È‚¢


## ƒEƒBƒ‹ƒRƒNƒ\ƒ“‚Ì•„†‡ˆÊŒŸ’è (2ŒQŠÔ‚É‘Î‰ž‚ª‚ ‚éê‡)
library(exactRankTests)
wilcox.exact(x = vx, y = vy, paired=T)
wilcox.exact(dis ~ sex, data=d, paired=F)
#¦ wilcox.test‚Íƒ^ƒC‚ª‚ ‚é‚Æ‚«‚É‚Í³Šm‚È’l‚ð•Ô‚³‚È‚¢


## ƒPƒ“ƒh[ƒ‹‚Ì‡ˆÊ‘ŠŠÖŒW”
cor.test(x1, x2, method="kendall")


## ƒNƒ‰ƒXƒJƒ‹ƒEƒHƒŠƒXŒŸ’è
d <- list(x, y, z)
kruskal.test(d)
# Post-hoc (Ž–ŒãŒŸ’è) (Nemenyi test, Anova‚Å‚ÌTukey‚ÉŽ—‚Ä‚¢‚é)
library(PMCMR)
posthoc.kruskal.nemenyi.test(d)


## Friedman test (‘Î‰ž‚ ‚éƒNƒ‰ƒXƒJƒ‹ƒEƒHƒŠƒXŒŸ’è)
# data‚Í•\Œ`Ž®
friedman.test(search_ind_mean)
# Post-hoc (Ž–ŒãŒŸ’è) (Nemenyi test, Anova‚Å‚ÌTukey‚ÉŽ—‚Ä‚¢‚é)
library(PMCMR)
posthoc.friedman.nemenyi.test((search_ind_mean))

## Scheirer-Ray-Hare test (2•W–{‚ÌƒNƒ‰ƒXƒJƒ‹ƒEƒHƒŠƒX‚É‘Î‰ž)
## Ref: Sokal, R.R. and F.J. Rohlf. 1995. Biometry. 3rd ed. W.H. Freeman, New York. pp146-147 
library(rcompanion)
ds <- data.frame(Rank_PC1, caste, colony)
scheirerRayHare(Rank_PC1~caste*colony, data=ds)

#---------------------------------------------------------------------------------------------------------------------------#
# Survival analysis
#---------------------------------------------------------------------------------------------------------------------------#
{
  ## Survival time analysis (non parametric) -------------------------------------------------------------------------------#
  library(survival)
  ge.sf <- survfit(Surv(time,cens)~treat, type = "kaplan-meier", data=gehan)
  summary(ge.sf)
  plot(ge.sf, lty=1:2, mark.t=T, conf.int=F)  # +‚Í‘Å‚¿Ø‚è
  survdiff(Surv(time,cens)~treat, rho=1, data=gehan)
  
  ## ggplot survival curve -------------------------------------------------------------------------------------------------#
  library("survminer")
  library(survival)
  df<-survfit(Surv(fronttime,cens)~species, type = "kaplan-meier", data=d_ffront)
  ggsurvplot(fit = df, data = Res,
             pval = F, pval.method = TRUE,
             risk.table = F, conf.int = FALSE,
             ncensor.plot = FALSE, size = 1, linetype = 1:3,
             legend.title = "Species", legend.lab=c("Hetero","Paraneo","Reticuli"),
             title="Spending time at the front",
             xlab="Time (sec)", ggtheme = theme_bw()  + theme(aspect.ratio = 0.75))

  ## Cox Proportional-Hazards Model ----------------------------------------------------------------------------------------#
  ge.sf <- coxph(Surv(time,cens)~treat+sex, type = "kaplan-meier", data=gehan)
  Anova(ge.sf)
  multicomparison<-glht(ge.sf,linfct=mcp(time="Tukey"))
  summary(multicomparison)

  ## Cox mixed effect Proportional-Hazards Model ---------------------------------------------------------------------------#
  library(coxme)
  m <- coxme(Surv(duration, cens) ~ sex + (1|ID), data = d.surv)
  summary(m)
  Anova(m)
}
#---------------------------------------------------------------------------------------------------------------------------#
##### Parametric #####

## 1•W–{tŒŸ’è
t.test(x, mu=0.5, alternative="two.sided")

## GLM: summary‚Ìbase‚É‚È‚éfactor‚Ì•ÏX Change base of factorical data in summary
sex <- rep(c("M","F"), each=10)	# e.g.) sex is the factorical data
sex <- factor(sex, levels=c("M", "F")) # M is base
sex <- factor(sex, levels=c("F", "M")) # F is base

## GLMM (id‚Ícolony‚Énest‚³‚ê‚Ä‚¢‚é)
r <- glmer(search~time+sex+(1|colony/id)+(1|spend),family=binomial(link="logit"), data=LDd[LDd$spend>24,])
f
## GLMMŒã‚Ì‘½d”äŠr
library(multcomp)
multicomparison<-glht(r,linfct=mcp(time="Tukey"))
# d$treat <-relevel(d$treat, ref="Nega") 
# multicomparison<-glht(r,linfct=mcp(time="Dunnett"))
summary(multicomparison)
# with interaction ŒðŒÝì—p
d$IntFac <- interaction(d$Branch, d$species, drop=T) 
r1 <- lmer(Length ~ IntFac + (1|colony/rep), data=d)
multicomparison1 <- glht(r1, linfct=mcp(IntFac = "Tukey")) 
summary(multicomparison1)


## GLM(binomial)‚ÅƒƒWƒXƒeƒBƒbƒN‹Èü‚ð‘‚­
r <- glm(~~~)
logistic <- function(x){ 1/(1+exp(-x)) } #•’Ê‚ÌƒƒWƒXƒeƒBƒbƒN‹Èü‚ðì‚é
Est <- summary(r)$coefficient[,1]#ŒW”‚Ì—\‘ª’l‚ðŽæ‚èo‚·
xdata <- seq(min(x), max(x),length.out=120) #x‚Ì”ÍˆÍ‚ðo—Í
ydata <- logistic(Est[1]+Est[2]*xdata) #y‚Ì’l‚ðŒvŽZ
lines(xdata, ydata)#ü‚ðã‘‚«


## Note for type III Anova
## You need to specify contrasts=list(Centralnest=contr.sum, Foragingsite=contr.sum)
r <- lmer(Pworker ~ Centralnest*Foragingsite + (1|Colony) + (1|Sampling), data=d)
Anova(r)
Anova(r, type=2)
Anova(r, type=3)

r <- lmer(Pworker ~ Centralnest*Foragingsite + (1|Colony) + (1|Sampling), data=d, contrasts=list(Centralnest=contr.sum, Foragingsite=contr.sum))
Anova(r, type=3)

##### Multivariate analysis #####

## Principal Component Analysis (PCA)
result <- prcomp(d[,5:13], scale=TRUE) 
biplot(result)
summary(result)

# Kaiser-Meyer-Olkin‚ÌƒTƒ“ƒvƒŠƒ“ƒO“KØ«Šî€iKMO, MSAj
kmo <- function(x)
{
  x <- subset(x, complete.cases(x)) # Remove the cases with any missing value
  r <- cor(x) # Correlation matrix
  r2 <- r^2 # Squared correlation coefficients
  i <- solve(r) # Inverse matrix of correlation matrix
  d <- diag(i) # Diagonal elements of inverse matrix
  p2 <- (-i/sqrt(outer(d, d)))^2 # Squared partial correlation coefficients
  diag(r2) <- diag(p2) <- 0 # Delete diagonal elements
  KMO <- sum(r2)/(sum(r2)+sum(p2))
  MSA <- colSums(r2)/(colSums(r2)+colSums(p2))
  return(list(KMO=KMO, MSA=MSA))
}


#####################
##### Phylogeny #####
#####################

## Edit sequence data (nexus)
read.nexus.data(file.path(PROJHOME,"\\phylogeny\\FcC_smatrix.nex"))

write.nexus.data(Mor.nex, paste0(today,"-Morphology.nex"), format = "standard", datablock = T,
                 interleaved = TRUE, charsperline = 100,
                 #interleaved = F, 
                 gap = "-", missing = "?")

## Tree data (nwk, tre)
# read tree
tree_no3rd <- read.tree("rootedTreeCockroaches.nwk")

# drop tip
tree.adjust <- drop.tip(tree.labeled, tree.labeled$tip.label[is.na(headwidth)])

#### Plot ####
# general
plot(tree, no.margin=TRUE,edge.width=1,cex=0.5)

# node label
nodelabels(text=1:tree$Nnode+Ntip(tree),node=1:tree$Nnode+Ntip(tree), cex=0.5)
  

#### Analysis ####

# Phylogenetic signal
Phylosig(tree, HWdata, method="K", test=FALSE)

#### Ancestral reconstruction
# Phylogenetic Contrasts
obj<-contMap(tree, HWdata, plot=T)

# Fitting
fit.bm <- fitContinuous(phy = tree, dat = HWdata, model = "BM")
fit.ou <- fitContinuous(phy = tree, dat = HWdata, model = "OU")
fit.eb <- fitContinuous(phy = tree, dat = HWdata, model = "EB")
fit.trend <- fitContinuous(phy = tree, dat = HWdata, model = "trend")
fit.white <- fitContinuous(phy = tree, dat = HWdata, model = "white")

####################
#### Others #####
################
library(rabi)
brute_IDs(3, redundancy=2, alphabet=5, num.tries = 10, available.colors = c("y","g","p","o","b"))

