# Build IRS E-Filer Datasets

This folder contains a set of functions that allow you to scrape nonprofit IRS 990 E-Filer data stored as XML files on Amazon's Web Server platform, and transform them into research databases. It also contains documentation for the process, including the Data Dictionary that defines all of the variables and production steps included in the research database.

See which variables are currently available in the [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Build_IRS990_E-Filer_Datasets/Data_Dictionary.md).

The processed research database can be downloaded directly from Dataverse.



## Open IRS 990 Data

The IRS has released electronically-filed 990 returns as XML files posted on AWS that look like this:

https://s3.amazonaws.com/irs-form-990/201541349349307794_public.xml

This format is challenging for scholars that are used to flat spreadsheets. We are creating some guides to working with this data in the R programming language (any community submissions for Stata or Python scripts are welcome). 

* Tutorial on Parsing Data from XML [ [RMD](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Quick_Guide_to_XML_in_R.Rmd) ] [ [PDF](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Quick_Guide_to_XML_in_R.pdf) ]



## Build a Dataset of 990 Returns

We have created a program to convert the 990 returns for a specified set of organizations and years from individual XML files into a single spreadsheet format to make it useful for analysis. 

To see the mechanics of building a dataset from the online returns, try the script below with this sample of 10 nonprofits which is a subset from the full [e-filers database](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_E-Filers_Index.Rmd). It will scrape the data from the XML files posted by the IRS and return available data as a flat spreadsheet.



```r
### INSTALL AND LOAD REQUIRED PACKAGES

install.packages( "dplyr" )
install.packages( "xml2" )

library( dplyr )
library( xml2 )


####  LOAD A TEST FILE FOR DEMO PURPOSES - tiny.index

source( "https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Build_IRS990_E-Filer_Datasets/development/tiny.index.R" )

# CONTAINS 10 NONPROFITS

unique( tiny.index$OrganizationName )


# HERE IS WHAT THE DATA LOOKS LIKE

head( tiny.index )


# VARIABLE NAMES

names( tiny.index )


# 36 ROWS OF DATA COVERING 5 YEARS AND BOTH 990 AND 990EZ FILINGS

nrow( tiny.index )
table( tiny.index$FilingYear )
table( tiny.index$FormType )







### LOAD THE PROGRAM TO BUILD THE DATASET FROM 990 RETURNS - buildCore()

source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Build_IRS990_E-Filer_Datasets/BUILD_EFILER_DATABASE.R")
args( buildCore )


# eins - list of all nonprofits to include in the dataset (of omitted will collect all in index file)
# index - the IRS index file to use
# years - which years of data to collect
# form.type - which forms to include - "990", "990EZ", "990PF"


# START SCRAPING 990 RETURNS

core.dataset <- buildCore( index=tiny.index, years=2011:2015, form.type=c("990","990EZ") )



# THE DATA SET WILL LOOK LIKE THIS:

core.dataset[ 1:5, c("NAME","EIN","FISYR","TAXFORM","TOTALREVCURRENT") ]

# A tibble: 5 × 5
#                                      NAME       EIN FISYR TAXFORM TOTALREVCURRENT
#                                     <chr>     <chr> <chr>   <chr>           <chr>
# 1 BROWN COMMUNITY DEVELOPMENT CORPORATION 562629114  2014   990EZ          116465
# 2       KIWANIS CLUB OF GLENDORA PROJECTS 270678774  2014   990EZ           39959
# 3                     CONFETTI FOUNDATION 464114252  2014   990EZ           22881
# 4                  THE SHEPHERD PLACE INC 510311790  2014     990          430457
# 5      WISE VOLUNTEER FIRE DEPARTMENT INC 261460932  2014     990           26316


print.data.frame( core.dataset ) # display full dataset







# WRITE TO A FILE

getwd()  # where will it be saved?

write.csv( core.dataset, "Core.csv", row.names=F )



```

The missing value NA's indicate either that the nonprofit did not provide information, or in some cases that the full 990 contains the questions but the 990-EZ does not (see the data dictionary for more information). 

## Data Modules

This table presents an basic overview of the sections of the 990 form, whether each section is included in the 990 exclusively or also in the 990-EZ.

SECTION | DESCRIPTION | 990 | 990-EZ | SCRIPT | DATA DICTIONARY
--------|-------------|-----|--------|--------|-------------------
Basic Information | Header Data | X | partial |   | 
Part I | Revenues, Expenses and Change in Assets  | X | partial | | 
Part I | Mission and Program | X | partial | | 
Part IV | Checklist of Activities  | X | ? | | 
Part V | Checklist of Tax Compliance  | X | ? | | 
Part VI Section A | Governance and Management  | X | ? | | 
Part VI Section B | Policies  | X | ? | | 
Part VI Section C | Diclosure  | X | ? | | 
Part VII | Compensation of Officers and Board Members  | X | ? | | 
Part VIII | Statement of Revenues  | X | | | 
Part IX | Statement of Functional Expenses  | X | | | 
Part X | Balance Sheet  | X |  | | 
Part XI | Reconciliation of Net Assets  | X |  | | 
Part XII | Financial Reporting  | X |  | | 

Schedules used required for a variety of disclosure and compliance requirements if nonprofits meet certain criteria. The following is a list of all schedules and whether 990-EZ filers would be required to submit as well (source: Wikipedia). The schedules that you will frequently see are A, B, D, M, and O.

Schedule |	Description |	Number of pages | Can be filed with Form 990-EZ?
-----|----------------------|--------------------------------|----------
Schedule A	 |	Public Charity Status and Public Support	 |	4	 |	Yes
Schedule B	 |	Schedule of Contributors	 |	8	 |	Yes
Schedule C	 |	Political Campaign and Lobbying Activities	 |	4	 |	Yes
Schedule D	 |	Supplemental Financial Statements	 |	5	 |	No
Schedule E	 |	Schools	 |	1	 |	Yes
Schedule F	 |	Statement of Activities Outside the United States	 |	4	 |	No
Schedule G	 |	Supplemental Information Regarding Fundraising or Gaming Activities	 |	3	 |	Yes
Schedule H	 |	Hospitals	 |	4	 |	No
Schedule I	 |	Grants and Other Assistance to Organizations, Governments, and Individuals in the United States	 |	2	 |	No
Schedule J	 |	Compensation Information	 |	3	 |	No
Schedule K	 |	Supplemental Information on Tax-Exempt Bonds	 |	2	 |	No
Schedule L	 |	Transactions With Interested Persons	 |	1	 |	Yes
Schedule M	 |	Noncash Contributions	 |	2	 |	No
Schedule N	 |	Liquidation, Termination, Dissolution, or Significant Disposition of Assets	 |	3	 |	Yes
Schedule O	 |	Supplemental Information to Form 990	 |	2	 |	No
Schedule R	 |	Related Organizations and Unrelated Partnerships	 |	4	 |	No


There are other modules that function more like relational databases. The 990 returns contain information about board members or individual grants made by private foundations. These sections have a one-to-many relationship (many board members are associated with each nonprofit), and are better built as a separate table that can be linked to a nonprofit through the EIN rather than adding them to the same database because of the structure of the data. 



## Advantages of the Open IRS Database

In addition to information currently available in NCCS Core files, we can include additional information that was not previously accessible such as lists of board members and specific Schedules.

The IRS releases new data every couple of months as it is available, so it is more-or-less in real time as nonprofits submit their returns. Alternatively, there is a 2-3 year time lag between when data is filed and when it is released by NCCS.


## Limitations of the Open IRS Database

We have modeled the database off of the The NCCS core datasets, as it has been the industry standard for scholarship for years. The NCCS core data dictionary is [available here](http://nccsweb.urban.org/PubApps/dd2.php?close=1&form=Core+2013+PC).

There are several limitations of the open IRS data relative to the core files:

* The IRS open data only includes organizations that have filed electronically (approximately 60% of all 990 and 990-EZ filers, and all organizations with revenues above $10 million). 
* The current IRS data does not include NTEE codes.
* The data has a street address, but is not geocoded or matched to county or MSA FIPS codes (which are necessary to merge with census data). 
 
Another limitation of all of these datasets is that the 990EZ forms contain a small subset of variables contained in the full 990 form. Any variables that do not have 


