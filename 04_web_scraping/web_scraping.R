install.packages("rvest") # usado para fazer web scraping
library(rvest)

mouse = data.frame(Name = NA, Price = NA)

url = 'https://www.americanas.com.br/categoria/informatica-e-acessorios/mouse/pagina-1'

page = read_html(url) # Lê a página na url

page %>% html_nodes("h2") # Separa a página de acordo com as tags HTML

pagenodes = html_nodes(x = page, xpath = "//div//h2")

texts = html_text(pagenodes) # Pega o conteúdode todos os h2 dentro de uma div, que são os nomes dos mouses

idtext = grep("Refinar",texts) 
newprod = texts[1:(idTexts-1)] # Pegar todos os que vierem antes de Refinar, pq depois é "lixo"