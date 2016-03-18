library(XML)
#
auUrl <- "http://www.panamatramita.gob.pa/instituciones"
auRaw <- htmlTreeParse(auUrl,useInternalNode =T,encoding="utf8")
# #print(auRaw)

tableNodes = getNodeSet(auRaw, "//table")
tb = readHTMLTable(tableNodes[[1]])
au_db <- data.frame(tb[1],tb[2])
names(au_db)<-c("Nombre","Link")
Url <- "http://www.panamatramita.gob.pa/instituciones?page="

for(i in 2:11)
{
  url2 <- paste0(Url,i)
  Raw2 <- htmlTreeParse(url2,useInternalNode =T,encoding="utf8")
  tableNodes = getNodeSet(Raw2, "//table")
  temp = readHTMLTable(tableNodes[[1]])
  temp_db <- data.frame(temp[1],temp[2])
  names(temp_db)<-c("Nombre","Link")
  au_db <- rbind(au_db, temp_db)
  print(temp_db[1])

}
names(au_db)<-c("Nombre","Link")
write.csv(au_db, file = "MyData.csv")
