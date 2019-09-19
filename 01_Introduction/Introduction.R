df <- read.delim("table_from_article.csv", comment.char="#") # Read a CSV file as a dataframe
cor(df) # gets the correlation matrix of the dataframe
x = df[,4:6]/apply(df[,4:6],1,sum) # matriz[<rows>,<column>]
# i:j = [i, ..., j]
# apply(<matriz>,<row=1/column=2>,<function>)
df2 = cbind(PCap = df[3]/df[,2],x,PACHS = df[,6]) # concatenate matriz in columns
cor(df2)
plot(df2[,3],df2[,1],pch=19,cex=1) # scatter plot
