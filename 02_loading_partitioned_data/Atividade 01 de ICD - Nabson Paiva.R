setwd("~/Documentos/UFAM/4º período/ICD/02_loading_partitioned_data")
breast <- read.table("breast.txt", header=FALSE, stringsAsFactors=FALSE)

vol_data = 0
size = 0
cnt = 1
while (size <= 10000) {
  br <- read.table("breast.txt", header=FALSE,
                   stringsAsFactors=FALSE, nrows=cnt)
  size = object.size(br)
  cnt = cnt + 1
}

vol_data = cnt -2
br2 = read.table("breast.txt", header=FALSE,
                 stringsAsFactors=FALSE, nrows=vol_data)
size = object.size(br2)
size

nPar = trunc(nrow(breast)/vol_data) + ifelse(nrow(br)%%vol_data>0,1,0)
nPar

media.vec = rep(0,length=ncol(br)-1)
maior.vec = c()
menor.vec = c()
for (k in 1:nPar) {
  br3 = read.table("breast.txt", header=FALSE,
                   stringsAsFactors=FALSE, nrows=vol_data, skip=(k-1)*vol_data)
  br3 = as.matrix(br3[,-31])
  menor.vec = apply(rbind(menor.vec,br3),2,min) # Correção
  # une o vetor de menores à partição e verifica o menor da coluna da matriz nova
  maior.vec = apply(rbind(maior.vec,br3),2,max) # Correção
  media.vec = media.vec + colSums(br3) 
  gc()
}
mediaPar = media.vec / nrow(breast)
mediaPar

var = rep(0,length=ncol(br)-1)
for (k in 1:nPar) {
  br3 = read.table("breast.txt", header=FALSE,
                   stringsAsFactors=FALSE, nrows=vol_data, skip=(k-1)*vol_data)
  br3 = as.matrix(br3[,-31])
  var = var + colSums((t(t(br3) - mediaPar))^2) # Correção
  # o vetor é interpretado como coluna na subtração, então é preciso transpor br para subtrair e então transpor de novo para
  # fazer o somatório da coluna
  gc() 
}
var = var / (nrow(breast)-1) # Correção
var
