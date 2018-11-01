# SESYNC_MPA_Global
A repository for the files and code associated with part 1 of the Ch-Ch-Changes MPA project. 

Very basic outline: 
1) Calculate the proportion of each cell that is within an MPA. This will be used to modify fishing effort within the cell as an input into the DBEM model. 
  - To do this I chose to use ArcGis and code in Python to make sure that I could check everything spatially. I have uploaded     the python code. The basic steps were to a) select out all of the protected areas that were marine or coastal. b) separate     those into no take or partial take/fishing. c) calculate the percentage of each cell that contains an MPA for no take and     all MPAs.
  
  - Column labels: 
    NoTakeMPAArea:    Area in decimal degrees of the MPA that is within the grid cell. No-take MPAs only
    NoTakePercent:    Percentage of the grid cell covered by MPA. No-take only
    AllMPAArea:    Area in decimal degrees of the MPA that is within the grid cell. All MPAs (no-take,partial, and open)
    AllPercent:       Percentage of the grid cell covered by MPA. All MPAs
    MPApresentNoTake:	1 = grid cell contains an MPA, 0 = does not contain. No-take only. 
    MPAPresentAll:    1 = grid cell contains an MPA, 0 = does not contain. All MPAs 

2) Re-run DBEM model with adjusted fishing effort for no-take MPAs.
3) Re-run DBEM model with adjusted fishing effort for all MPAs (Hypothetical scenario: if all MPAs were turned into no-take MPAs). 
4) Compare values from both MPA outputs to the base case model (Climate change under RCP 2.6 and 8.5) 
