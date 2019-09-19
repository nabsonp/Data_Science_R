library(rvest)
library(stringr)
setwd("~/Documentos/UFAM/4º período/ICD/05_web_scraping_2")
url = "boticario.html"
page = read_html(url,encoding="utf-8")

# Get product name
node = html_nodes(page,css=".shelf-product-name") # Pega as tags da classe passada
prod = html_text(node)

# Get product price
node = html_nodes(page,css = ".shelf-product-price")
price = html_text(node)

# Get product ID
node = html_nodes(page,xpath = "//div//div//like-button")
id = t(simplify2array(html_attrs(node)))[,1] # Recebe os atributos da tag
# Simplify2array transoforma a lista em um vetor, que tem duas linhas, então transpõe e pega só a primeira coluna (ID)

# Get the url of product images
node = html_nodes(page,css = ".product__image>img")
image = t(simplify2array(html_attrs(node)))[,'src'] # Gets the links of all the product images

# Create the DataFrame
df = data.frame(Id = id, Product = prod, Price = price,Img_url=image)
View(df)

# Donwload the images by the url
for (i in 1:nrow(df)) {
  download.file(url=as.character(df[i,"Img_url"]),destfile = paste0("image_products/",df[i,'Id'],".jpg"),mode="wb")
}

write.csv(df,file="Boticario.csv")
