#####################################################################
##                This code is written by Sujan Mamidi             ##
######   Rcode to obtain frequency distribution of SNP.      #######
######                       ########                        #######
########          This code is licensed under the           #########
########          GNU General Public License v3.0           #########
#####################################################################

### required input - textfile, spaceseparated, no headings
### EX: 
##Chr01 25
##Chr01 35
##Chr02 40



sliding_window_frequency <- function(infile,window=10000, slide=2000){
    
    ## Check if it has required criteria for subset
   
    
    myData <- read.table(infile, header=FALSE)
    colnames(myData) <- c("Chr","pos")
    
    numslides <- window/slide    
    
    ## Create an empty dataframe
    Scount <- data.frame(Chrom=character(),
    S=integer(),
    Start_Mbp=integer(),
    End_Mbp=integer(),
    stringsAsFactors=FALSE)
  
    ## A loop to create multiple temporary df
    for (i in 1:numslides){
        
        myData$region <- floor((myData$pos-((i-1)*slide))/window)
        newdf <- aggregate(myData$pos ~ myData$Chr+myData$region, data=myData, FUN=length)
        
        colnames(newdf) <- c("Chrom","region","S")
        newdf$Start_Mbp <- ((newdf$region * window) + ((i-1)*slide))/1000000
        newdf$End_Mbp <- newdf$Start_Mbp + (window/1000000)
        newdf$region <- NULL
        myData$region <- NULL
        
        Scount<-rbind(Scount, newdf)
        rm(newdf)
    }
    
    ## Edit/Format the final dataset
    Scount <- Scount[which(Scount$Start_Mbp >= 0),]
    Scount <- Scount[order(Scount$Chr, Scount$Start_Mbp),]
    Scount <- Scount[c("Chrom", "Start_Mbp", "End_Mbp", "S")]
    
    ## write and outfile
    outfile <- paste(infile,window,slide,"freq_dist.txt", sep = "_")
    
    write.table(Scount,outfile, quote = FALSE, sep = " ", col.names = TRUE, row.names = FALSE)
    
}
