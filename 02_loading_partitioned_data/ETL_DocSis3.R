#### Classe Control
setwd("~/Documentos/UFAM/4º período/ICD/Aula 02 - Breast") # fixa a pasta de trabalho do R no diretório passado. 
setwd("control")
fileNames = dir()

for (k in 1:length(fileNames)) {
  Log = readLines(fileNames[k])
  idFP = grep("Freq\tPower",Log) + 1
  Log = Log[idFP:length(Log)]
  
  if (k == 1) {
    logsplited = strsplit(Log, split="\t")
    logarray = t(simplify2array(logsplited))
    DATA = matrix(as.numeric(logarray[,2]),1,nrow(logarray),dimnames=list(1,logarray[,1]))
    DATA = as.data.frame(DATA)
  } else {
    logsplited = strsplit(Log, split="\t")
    logarray = t(simplify2array(logsplited))
    DATA[k,] = as.numeric(logarray[,2])
  }
}
DATA = data.frame(DATA,CLASS=1)

#### Classe Error
setwd("~/Documentos/UFAM/4º período/ICD/Aula 02 - Breast") # fixa a pasta de trabalho do R no diretório passado. 
setwd("error")
n = nrow(DATA)
fileNames = dir()

for (k in 1:length(fileNames)) {
  Log = readLines(fileNames[k])
  idFP = grep("Freq\tPower",Log) + 1
  Log = Log[idFP:length(Log)]
  logsplited = strsplit(Log, split="\t")
  logarray = t(simplify2array(logsplited))
  DATA[n+k,-ncol(DATA)] = as.numeric(logarray[,2])
  DATA[n+k,ncol(DATA)] = 2
}

View(DATA)

