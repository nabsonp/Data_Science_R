  
# install.packages("rvest") # usado para fazer web scraping

library(rvest)
library(stringr)
df = data.frame(Product = NA, Price = NA)
#
URL = "https://www.olx.com.br/brasil?o=PAGINA&q=im%C3%B3veis%20a%20venda%20em%20manaus&sf=1"
k = 1
while (k < 11) {
  url = sub(x=URL,pattern = 'PAGINA',replacement = k)
  page = read_html(url) # Lê a página na url
  
  # Get product names ----
  pagenode = html_nodes(x = page, xpath = "//div//li//a//div//div//h2") # Separa a página de acordo com as tags HTML
  texts   = html_text(pagenode) # Pega o nome dos produtos
  prod = str_replace_all(texts,'\t','')
  prod = str_replace_all(prod,'\n','')
  
  # Get product price ----
  pagenode = html_nodes(x = page, xpath = "//div//li//a//p")
  texts    = html_text(pagenode)
  idtext   = grep(":| R\\$", texts) # Pego somente os preços e horários, para analisar quais que não têm preço
  texts    = texts[idtext]
  i = 1
  j = 1
  l = length(texts)
  price = c() # Usado para separar preços de horários de postagem
  while (i < l) {
    if (!grepl("R",texts[i])){
      price[j] <- NA # Alguns produtos não têm preço na página
      i = i + 1
    } else {
      price[j] <- texts[i]
      # Trata o fato de que podem ter dois preços no produto, o antigo e o atual
      if (grepl("R",texts[i+1])) {
        i = i + 3
      } else {
        i = i + 2
      }
    }
    j = j + 1
  }
  price = str_replace_all(price,' ','')


    # ----
  df = rbind.data.frame(df,cbind.data.frame(Product = prod,Price = price))
  
  cat("Page: ", k ,"\t Products: ",nrow(df)-1,"\n")
  k = k + 1 
  Sys.sleep(runif(1,0,5))
}
df = df[-1,]
View(df)
setwd("~/Documentos/UFAM/4º período/ICD/04_web_scraping")
write.csv(df, "web_scrapping_olx.csv", row.names = TRUE)










