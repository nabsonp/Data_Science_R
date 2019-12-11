

install.packages("jpeg")
library(jpeg)


dogs = readJPEG("doguinhos.jpg")
dim(dogs) # shows the image dimension
dev.new()
plot(1:2, type='n')

rasterImage(dogs, 1, 1, 2, 2)

DATA = data.frame(R = c(dogs[,,1]),G = c(dogs[,,2]), B = c(dogs[,,3]))
View(DATA)
mod = kmeans(DATA, centers = 2)
cl = mod$cluster
for(i in 1:nrow(DATA)){
  if(cl[i] == 1){
    DATA[i,] = c(0,0,1)
  }
}

R = matrix(DATA[,1],325,480)
G = matrix(DATA[,2],325,480)
B = matrix(DATA[,3],325,480)

dogs2      = array(0,dim = c(325,480,3))
dogs2[,,1] = R
dogs2[,,2] = G
dogs2[,,3] = B
dev.new()
plot(1:2, type='n')

rasterImage(dogs2, 1, 1, 2, 2)

####### Nose

nose = readJPEG("nose.jpg")
DATA2 = data.frame(R = c(nose[,,1]),
                   G = c(nose[,,2]), 
                   B = c(nose[,,3]))

summary(DATA2)
pairs(DATA2)
hist(DATA2[,1])
hist(DATA2[,2])
hist(DATA2[,3])

library(mixsmsn)
library(sn)
modsn = smsn.mmix(y = DATA2, g = 1, family = "Normal")




for(i in 1:nrow(DATA)){
  p = pmsn(DATA[1,],xi=modsn$mu[[1]],
       ,Omega =  modsn$Sigma[[1]]
       , alpha = c(modsn$shape[[1]]))
  if(p >=0.2 & p <=0.8){
    DATA[i,] = c(0,1,0)
  }
}
R = matrix(DATA[,1],325,480)
G = matrix(DATA[,2],325,480)
B = matrix(DATA[,3],325,480)

dogs2      = array(0,dim = c(325,480,3))
dogs2[,,1] = R
dogs2[,,2] = G
dogs2[,,3] = B
dev.new()
plot(1:2, type='n')

rasterImage(dogs2, 1, 1, 2, 2)

