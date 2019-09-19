# Put your datapath before the file name or load the data with R Studio
breast <- read.table("breast.txt", header=FALSE, stringsAsFactors=FALSE)

# If there is any string and you may want to insert some news,stringsAsFactor=FALSE
# read.table is just like read.delim, used to load structured data
# read.table accepts the link of the base

dim(breast) # dataframe dimension (rowXcolumn)

object.size(breast) # size of the object in bytes

# If you want to work with just a slice of the file, you need to estimate the size of the data that the RAM can manage (Ex.:10KB)
vol_data = 0
size = 0
cnt = 1
while (size <= 10000) {
  br <- read.table("breast.txt", header=FALSE,stringsAsFactors=FALSE, nrows=cnt)
  # nrows defines the numer of rows that will be read
  size = object.size(br)
  cnt = cnt + 1
}

# Now you now the numer of rows that will not overcharge your RAM 
vol_data = cnt -2
br2 = read.table("breast.txt", header=FALSE,stringsAsFactors=FALSE, nrows=vol_data)
size = object.size(br2)
size

# Number of partitions
nPar = trunc(nrow(breast)/vol_data) + ifelse(nrow(br)%%vol_data>0,1,0)
nPar

###### Claculate the mean of a large dataset
## Load the data in partitions
media.vec = rep(0,length=ncol(br)-1)
for (k in 1:nPar) {
  br3 = read.table("breast.txt", header=FALSE,stringsAsFactors=FALSE, nrows=vol_data, skip=(k-1)*vol_data)
  br3 = as.matrix(br3[,-31])
  media.vec = media.vec + colSums(br3) # sums all the columns of the ds
  gc() # frees unused memory space
  print((skip=(k-1)*vol_data):(skip=k*vol_data))
  print(object.size(br3))
  print(nrow(br3))
  # the argument skip mark where the reading will begin in bytes
}
mediaPar = media.vec / nrow(breast)
mediaPar

colMeans(breast[,-31])


