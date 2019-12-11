library(rvest)
library(stringr)
#setwd("~/Documentos/UFAM/4º período/ICD/07_cosmos_blue_software")
url = "https://cosmos.bluesoft.com.br/ncms/22011000-aguas-minerais-e-aguas-gaseificadas/products?page=PAGINA"
df = data.frame(Product = NA)

k = 1
while (k <= 50) {
  url_k = sub(x=url,pattern = 'PAGINA',replacement = k)
  page = read_html(url_k,encoding="utf-8")
  
  # Get product name
  pagenode = html_nodes(x = page, xpath = "//div//div//h5//a") 
  names   = html_text(pagenode) 
  
  df = rbind.data.frame(df,cbind.data.frame(Product = names))
  cat("Page: ", k ,"\t Products: ",nrow(df)-1,"\n")
  k = k + 1 
  Sys.sleep(runif(1,0,5))
}

url = "https://cosmos.bluesoft.com.br/ncms/22030000-cervejas-de-malte/products?page=PAGINA"
k = 1
while (k <= 107) {
  url_k = sub(x=url,pattern = 'PAGINA',replacement = k)
  page = read_html(url_k,encoding="utf-8")
  
  # Get product name
  pagenode = html_nodes(x = page, xpath = "//div//div//h5//a") 
  names   = html_text(pagenode) 
  
  df = rbind.data.frame(df,cbind.data.frame(Product = names))
  cat("Page: ", k ,"\t Products: ",nrow(df)-1,"\n")
  k = k + 1 
  Sys.sleep(runif(1,0,5))
}
df = df[-1,]
View(df)
write.csv(df, "bebidas.csv", row.names = TRUE)