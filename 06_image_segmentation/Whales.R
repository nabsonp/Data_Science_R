# install.packages("jpeg")
library(jpeg)

whale = readJPEG("images/w_0.jpg")
dim(whale) # shows the image dimension
dev.new()
plot(1:2, type='n')

rasterImage(whale, 1, 1, 2, 2)
# creates a dataframe with the RGB values of the pixels
DATA = data.frame(R = c(whale[,,1]),G = c(whale[,,2]), B = c(whale[,,3]))
View(DATA)
# uses the k-means method to devide the image into two parts (centers=2)
mod = kmeans(DATA, centers = 2)
# paints the pixels classified like class 2 with blue
cl = mod$cluster
for(i in 1:nrow(DATA)){
  if(cl[i] == 1){
    DATA[i,] = c(0,0,1)
  }
}

# shows the result of the image processing
R = matrix(DATA[,1],325,480)
G = matrix(DATA[,2],325,480)
B = matrix(DATA[,3],325,480)
whale2      = array(0,dim = c(325,480,3))
whale2[,,1] = R
whale2[,,2] = G
whale2[,,3] = B
dev.new()
plot(1:2, type='n')

# prints the result image
rasterImage(whale2, 1, 1, 2, 2)

####### Whales in the sea
DATA2 = data.frame(R = NA,
                   G = NA, 
                   B = NA)
i = i +1
for (i in 1:14) {
  wh = readJPEG(paste0("whales/w",i-1,".jpg"))
  d = data.frame(R = c(wh[,,1]),
                   G = c(wh[,,2]), 
                   B = c(wh[,,3]))
  DATA2 = merge(DATA2,d,all=T)
}
View(DATA2)
hist(DATA2[,1])
hist(DATA2[,2])
hist(DATA2[,3])

install.packages("sn")
install.packages("mixsmsn")
install.packages("mvtnorm")
library(mixsmsn)
library(sn)
modsn = smsn.mmix(y = DATA2, g = 1, family = "Normal")

for(i in 1:nrow(DATA)){
  p = pmsn(DATA[1,],xi=modsn$mu[[1]],Omega =  modsn$Sigma[[1]], alpha = c(modsn$shape[[1]]))
  if(p >=0.2 & p <=0.8){
    DATA[i,] = c(0,1,0)
  }
}

R = matrix(DATA[,1],325,480)
G = matrix(DATA[,2],325,480)
B = matrix(DATA[,3],325,480)

whale2      = array(0,dim = c(325,480,3))
whale2[,,1] = R
whale2[,,2] = G
whale2[,,3] = B
dev.new()
plot(1:2, type='n')

rasterImage(whale2, 1, 1, 2, 2)

