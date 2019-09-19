###### Classe de Controle = 1
setwd("~/Documentos/UFAM/4º período/ICD/03_data_structuring/wifi/Control") # fixa a pasta de trabalho do R no diretório passado. 
fileNames = dir()
l <- rep(0,21)
l[21] = 1
df <- data.frame("Data_Hora" = '', "Teste" = '', "Antena" = '', "Channel" = '', "Freq" = '',
                 "Occ_Band" = '', "Sit_Teste" = '',"Power" = '', "Sit_Power" = '', "N_outsig" = '', 
                 "N_3sig" = '', "N_2sig" = '', "N_1sig" = '', "U" = '', "P_1sig" = '', "P_2sig" = '', 
                 "P_3sig" = '', "P_outsig" = '', "Sit" = '', "Log" = '', "Classe" = 1, stringsAsFactors = FALSE)

for (k in 1:length(fileNames)) {
  Log = readLines(fileNames[k])
  idFP = grep("Modelo",Log)
  Log = Log[idFP:length(Log)]
  a = strsplit(Log[3], split="")[[1]]
  a[11] = " "
  l[1] = paste0(a,collapse = "")
  tst = grep("Teste",Log)
  l[20] = fileNames[k]
  for (j in tst) {
    t = strsplit(Log[j],split=" ")[[1]]
    l[2] = t[2]
    l[3] = t[4]
    l[4] = t[6]
    l[5] = t[8]
    l[6] = t[12]
    l[7] = strtrim(t[13],6)
    l[8] = t[16]
    l[9] = strtrim(t[17],6)
    t = strsplit(Log[j+1],split=" ")[[1]]
    l[10] = strsplit(t[7],split="}")[[1]][1]
    for (a in 9:14) {
      l[a+2] = strsplit(t[a],split="}")[[1]][1]
    }
    l[19] = t[17]
    df = rbind(df,l)
  }
}
df = df[-1,]
rownames(df) <- 1:nrow(df)

###### Classe de Erro = 2
setwd("~/Documentos/UFAM/4º período/ICD/03_data_structuring/wifi/Error") # fixa a pasta de trabalho do R no diretório passado. 
fileNames = dir()
l[21] = 2

for (k in 1:length(fileNames)) {
  Log = readLines(fileNames[k])
  idFP = grep("Modelo",Log)
  Log = Log[idFP:length(Log)]
  a = strsplit(Log[3], split="")[[1]]
  a[11] = " "
  l[1] = paste0(a,collapse = "")
  tst = grep("Teste",Log)
  l[20] = fileNames[k]
  for (j in tst) {
    t = strsplit(Log[j],split=" ")[[1]]
    l[2] = t[2]
    l[3] = t[4]
    l[4] = t[6]
    l[5] = t[8]
    l[6] = t[12]
    l[7] = strtrim(t[13],6)
    l[8] = t[16]
    l[9] = strtrim(t[17],6)
    t = strsplit(Log[j+1],split=" ")[[1]]
    l[10] = strsplit(t[7],split="}")[[1]][1]
    for (a in 9:14) {
      l[a+2] = strsplit(t[a],split="}")[[1]][1]
    }
    l[19] = t[17]
    df = rbind(df,l)
  }
}
View(df)
setwd("~/Documentos/UFAM/4º período/ICD/03_data_structuring") # fixa a pasta de trabalho do R no diretório passado. 
write.csv(df, "wifi_estruturado.csv", row.names = TRUE)
