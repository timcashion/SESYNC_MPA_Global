#### READ ME ####
#### February 1st, 2017 ###
#### Author: Juliano Palacios ##
#j.palacios@oceanas.ubc.ca

##### Usage ####
# This function works to extract single species data from the DBEM folder in the NEREUS drobo. For the function to work you must be connected to the drobo trough the IOF network since the function uses a standardized path.

#Packages needed: ####
#To use this function you must install the following packages:
#data.table
#https://cran.r-project.org/web/packages/data.table/data.table.pdf

#Run the following code if you don’t have the package:
#install.packages("data.table", repos = "https://Rdatatable.github.io/data.table", type = "source")

#Function Structure: ####

#dbem_Import(TaxonKey,Initial_Y,Final_Y,IPCC=2.6,Data_Type="Catch")
#Output: A datatable where the first column represents the INDEX (see Drobo reference document) and the following columns represent years of data. 

#NOTE: If grids (INDEX) are found in one year, but not in the other, the function will assing NA's to that empty value.

#### Terminology :
#TaxonKey, the Taxon Key of the species you want the information. Refer to "exploited_species_list.csv".
#Initial_Year, The initial year of data
#Final_Year, The final year of data
#IPCC, it referes to the IPCC emissions scenarios. The default setting for the function is 2.6.
# Values: IPCC = 2.6 or 8.5
#Data_Type, DBEM has two types of data ("Catch and Abd". The defoult setting for the function is defaulted for"Catch" data. 
# Values: Data_Type = "Catch" or "Abd"


#That's it, have fun and don’t hesitate to contact me for code improvement! 
#______________________________________________________________________________#

#### The Function ####


dbem_Import <- function(TaxonKey,
                        Initial_Y,
                        Final_Y,
                        Model,
                        Data_Type){
  
#Install (if needed) and load data.table package
  if(!require(data.table)){
    install.packages("data.table")
    library(data.table)
  }
  
  # Creat a sequence of the years to import  
  Year <- seq(Initial_Y,
              Final_Y,
              by=1) #<- change this setting if you have bi/tri/etc annual data
  
  # For the forloop
  Datos <- list()
  D_Path <- paste()
  
#### Set the Path####
#First, set the path of the files under a loop for each year
  #OBSERVATION: Change the pathway to YOUR computer #
  
      D_Path <- paste("/Volumes/DATA/DATA/DBEM/",Model,"/", #<- drobo path for 8.5
                      TaxonKey,"/",TaxonKey,Data_Type,Year,".txt",
                      sep="")
    
    total <- NULL
    
    #### Importing data ####
    #Now we import the data using data.table::fread and the path generated above
    
    
    for (i in 1:length(Year)){ #<- #The years you want to have 
      
      possibleError <-  tryCatch({ # <- This will solve for species with different years data
        # Imports dataset 
        cur <- fread(D_Path[i],
                   na.strings = "NA",
                   col.names = c("INDEX",
                                 Year[i]) #<- Calls colunmns by year
                   )
        
                  #Puts them together in one nice dataset 
      if(i == 1){
        total<- copy(cur) # <- copies the previouse data.table
      }else{ 
        setkey(total, # <- sets the data.table as "reference" ?setkey
               INDEX); setkey(cur,
                              INDEX); 
        total <- merge(total, #<- Merges all the data in one single file.
                       cur,
                       all = TRUE) # <- This allows for the NA's
      } #Close datatable loop  
      
      },
      error=function(e){
        e
        # print(paste("Oops! --> No information for year ",1950+i,sep = "")) # <- Display error message
      }
      )
      if(inherits(possibleError, "error")) next() # <- Breaks loop
  
  } #First loop END (Path Creation)
   
  
    print(paste("Analysis done for",TaxonKey, Model))
  
  return(total)
 } #Function end

