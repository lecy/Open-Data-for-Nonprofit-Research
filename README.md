# Open Data for Nonprofit Research

Nonprofit sector advocates have waged concerted efforts to make IRS 990 tax data on public charities and foundations available in free, machine-readable formats. As a result of this work the IRS released 990 tax data from electronic filers in June of 2016. This project was created to make this data easily accessible to nonprofit scholars and researchers. 

The new IRS 990 data repository, hosted at Amazon and [found here](https://aws.amazon.com/public-data-sets/irs-990/), represents a significant stride forward in making data open and timely. Unfortunately the data have been released in formats that are not always easy to use - ASCII text files, json files, and XML queries. In order to make the data accessible to the research community, we have created scripts to download data from IRS websites, clean and process it, and export into familiar formats (CSV, Stata, SPSS, etc.).

These scripts are written in the R language because it is a freely-available open-source platform that can be used by anyone. This project was inspired by the [R Open Science](https://ropensci.org/) initiative, which believes in making data accessible and building tools that help a research community better utilize the data. You can install R for Windows [here](https://cran.r-project.org/bin/windows/base/) or R for Macs [here](https://cran.r-project.org/bin/macosx/). 

## Build IRS Nonprofit Databases

Scripts are currently available to build several IRS databases available online:

* [Index of 990, 990-EZ and 990-PF Electronic Filers from 2010 to Present](./Build_Datasets/electronic filers.Rmd)
* [All Current Exempt Organizations (all orgs granted 501(c)(3) status)](./Build_Datasets/current master exempt list.Rmd)
* [All 990-N Postcard Filers](./Build_Datasets/postcard 990N filers.RMD) 
* [All Organizations with a Revoked 501(c)(*) Status](./Build_Datasets/revoked organizations.Rmd)


## Working with Open IRS 990 Returns Data

The IRS has released electronically-filed 990 returns as XML files that look like this:

https://s3.amazonaws.com/irs-form-990/201541349349307794_public.xml

This format is challenging for scholars that are used to flat spreadsheets. We are creating some guides to working with this data in the R programming language (any community submissions for Stata or Python scripts are welcome). 

* Tutorial on Parsing Data from XML [ [RMD](./Resources/Quick_Guide_to_XML_in_R.Rmd) ] [ [PDF](./Resources/Quick_Guide_to_XML_in_R.pdf) ]



## Build a Dataset of 990 Returns

We have created a program to convert the 990 returns for a specified set of organizations and years from individual XML files into a single spreadsheet format to make it useful for analysis. You can try it out with this sample of 10 nonprofits:

```r
### INSTALL AND LOAD REQUIRED PACKAGES

install.packages( "dplyr" )
install.packages( "xml2" )

library( dplyr )
library( xml2 )


####  LOAD A TEST FILE FOR DEMO PURPOSES - tiny.index

source( "https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper_Functions/tiny.index.R" )

# CONTAINS 10 NONPROFITS

unique( tiny.index$OrganizationName )


# 36 ROWS OF DATA COVERING 5 YEARS AND BOTH 990 AND 990EZ FILINGS

nrow( tiny.index )
table( tiny.index$FilingYear )
table( tiny.index$FormType )




# HERE IS WHAT THE DATA LOOKS LIKE

head( tiny.index )


# VARIABLE NAMES

names( tiny.index )


### LOAD THE PROGRAM TO BUILD THE DATASET FROM 990 RETURNS - buildCore()

source("https://raw.githubusercontent.com/lecy/Open-Data-for-Nonprofit-Research/master/Helper_Functions/buildCore.R")
args( buildCore )


# eins - list of all nonprofits to include in the dataset (of omitted will collect all in index file)
# index - the IRS index file to use
# modules - which variables to include in the dataset based upon sections of the 990
# years - which years of data to collect
# form.type - which forms to include - "990", "990EZ", "990PF"


# START SCRAPING 990 RETURNS !

core.dataset <- buildCore( index=tiny.index, years=2011:2015, form.type=c("990","990EZ"), modules="basic"  )

print.data.frame( core.dataset )



# WRITE TO A FILE

getwd()  # where will it be saved?

write.csv( core.dataset, "Core.csv", row.names=F )

###

```

Sections of the 990 Forms that Can Be Included in the Build:

* Basic Information (Header Data):  [ [script](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Helper_Functions/getBasicInfo.R) ] [ data dictionary ]
* Part I - Revenues, Expenses and Change in Assets
* Mission and Program
* Part IV - Checklist of Activities
* Part V - Checklist of Tax Compliance
* Part VI Section A - Governance and Management
* Part VI Section B - Policies
* Part VI Section C - Diclosure
* Part VII - Compensation of Officers and Board Members
* Part VIII - Statement of Revenues
* Part IX - Statement of Functional Expenses
* Part X - Balance Sheet
* Part XI - Reconciliation of Net Assets
* Part XII - Financial Reporting
* Schedule A
* Schedule B
* Schedule D
* Schedule M
* Schedule O

There are other modules that function more like relational databases. The 990 returns contain information about board members or individual grants made by private foundations. These sections have a one-to-many relationship (many board members are associated with each nonprofit), and are better built as a separate table that can be linked to a nonprofit through the EIN rather than adding them to the same database because of the structure of the data. 

If you are interested in data that is not included in the current build, you can create a new module to add data to the dataset. It is a fairly straight-forward process and does not require a lot of programming knowledge, other than definining the variable list and documenting the definition (990 field) for each variable you create. 

You can generate the variable list by running [this script]((https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Helper_Functions/generateAllXpaths.R)). Building a module requires you to define variables by identifying the different ways they are referenced in the four versions of the 990, the results looking something [like this](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Helper_Functions/getBasicInfo.R). See the [Quick Guide to XML in R](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Quick_Guide_to_XML_in_R.pdf) for more details.

We welcome any contributions!



## Limitations

We have modeled the database off of the The NCCS core datasets, as it has been the industry standard for scholarship for years. The NCCS core data dictionary is [available here](http://nccsweb.urban.org/PubApps/dd2.php?close=1&form=Core+2013+PC).

There are several limitations of the open IRS data relative to the core files:

* The IRS open data only includes organizations that have filed electronically (approximately 60% of all 990 and 990-EZ filers, and all organizations with revenues above $10 million). 
* The current IRS data does not include NTEE codes.
* The data has a street address, but is not geocoded or matched to county or MSA FIPS codes (which are necessary to merge with census data). 
 
Another limitation of all of these datasets is that the 990EZ forms contain a small subset of variables contained in the full 990 form. Any variables that do not have 


## Advantages 

In addition to information currently available in NCCS Core files, we can include additional information that was not previously accessible such as lists of board members and specific Schedules. 

## Research Tools

Nonprofit data can be difficult to use because of messy data, multiple filing options, and changes to the 990 forms over time. 

Since there is a large community of researchers using 990 data, many issues have already been identified and addressed through scripts to clean, re-code, merge, or reconcile data. We are encouraging people to submit their solutions in order to develop collective resources and encourage convergence in how variables like overhead and financial ratios are defined and calculated. 

Please send your work if it represents solutions to problems that fall under the following categories: 

* Cleaning 990 Data
* Reconciling Data Fields Over Time
* [Merging 990 Data with Other Sources](https://gist.github.com/lecy/0aa782a873cd174573f32d243233ca5b)
* Geocoding Nonprofits

For instructions on submitting a solution, email Jesse Lecy: jdlecy@syr.edu


## Research Library

If you know of an article, blog, or research vignette that does a good job explaning methods for working with nonprofit data, let us know and we will share it. For example:

*Feng, N. C., Ling, Q., Neely, D., & Roberts, A. A. (2014). Using archival data sources to conduct nonprofit accounting research. Journal of Public Budgeting, Accounting & Financial Management.*

> In an effort to broaden the awareness of the data sources and ensure the quality of nonprofit research, we discuss archival data sources available to nonprofit researchers, data issues, and potential resolutions to those problems. Overall, our paper should raise awareness of data sources in the nonprofit area, increase production, and enhance the quality of nonprofit research.

*Lecy, J., & Thornton, J. (2015). What Big Data Can Tell Us About Government Awards to the Nonprofit Sector Using the FAADS. Nonprofit and Voluntary Sector Quarterly.*

The authors share a script for merging federal contracting data with IRS 990 data using names and addresses of organizations in the absence of a unique key shared by both databases (usually the EIN). It can be accessed [HERE](https://github.com/lecy/FAADS-NCCS-Crosswalk/blob/master/README.md). 


## Liberating the 990 Data

For some background on the campaigns to open access to IRS data, see these articles and blogs:

* [Liberating 990 Data](http://ssir.org/articles/entry/liberating_990_data): Stanford Social Innovation Review
* [The Nonprofit Data Project Blog](https://www.aspeninstitute.org/programs/program-on-philanthropy-and-social-innovation-psi/nonprofit-data-project-updates/): The Aspen Institute
* [IRS Plans to Begin Releasing Electronically Filed Nonprofit Tax Data](https://philanthropy.com/article/IRS-Plans-to-Begin-Releasing/231265): Chronicle of Philanthropy
* [Mandatory E-Filing: Toward a More Transparent Nonprofit Sector](http://www.urban.org/research/publication/mandatory-e-filing-toward-more-transparent-nonprofit-sector): The Urban Institute
* [Recommendations for Improving the Effectiveness of the 990 Form for Reporting[(https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/IRS%20ACT%20Report%202015.pdf): Advisory Committee on Tax-Exempt and Government Entities (ACT) Report



## Useful Information About 990 Data

Example Forms:

* [990](./Resources/Form 990-PC 2015.pdf)
* [990-EZ](./Resources/Form 990-EZ 2015.pdf)
* [990-PF]((./Resources/Form 990-PF 2015.pdf))
* [990-N Postcard](./Resources/Information Needed to File e-Postcard)

A History of the Tax Exempt Sector: An SOI Perspective [ [LINK](https://www.irs.gov/pub/irs-soi/tehistory.pdf) ]

A Guided Tour of the 990 Form by GuideStar [ [LINK](https://www.guidestar.org/ViewCmsFile.aspx?ContentID=4208) ]

Revised Form 990: The Evolution of Governance and the Nonprofit World [ [LINK](http://www.thetaxadviser.com/issues/2009/aug/revisedform990theevolutionofgovernanceandthenonprofitworld.html) ]

Wikipedia: History of the 990 [ [LINK](https://en.wikipedia.org/wiki/Form_990#History) ]

* Form 990 was first used for the tax year ending in 1941. It was as a two-page form. Organizations were also required to include a schedule with the names and addresses of payees who had given the organization at least $4,000 during the year.

* The form reached four pages (including instructions) in 1947. In 1976 this was increased to 5.5 pages (including instructions), with 8 pages for Schedule A. By 2000 this was 6 pages for Form 990, 42 pages for instructions, 6 pages for Schedule A, and at least 2 pages for Schedule B. This increase is due to use of a larger font and inclusion of sections that are only required for some organizations.

* Starting in 2000, political organizations were required to file Form 990.

* In June 2007, the IRS released a new Form 990 that requires significant disclosures on corporate governance and boards of directors. These new disclosures are required for all nonprofit filers for the 2009 tax year, with more significant reporting requirements for nonprofits with over $1 million in revenues or $2.5 million in assets.



## Additional Resources of Note 

Can we develop these further to augment the IRS data in interesting ways?

* [Foundation Center API](http://data.foundationcenter.org/about.html)
* [Guidestar APIs](https://community.guidestar.org/groups/developer)
* [Religious Congregation Data](http://www.thearda.com/archive/browse.asp)
* [Dark Money Given to Nonprofits](http://www.opensecrets.org/dark-money/explore-our-reports.php)


## Contact

If you are interested in submitting resources or building tools to support nonprofit scholarship please contact Jesse Lecy (jdlecy@syr.edu) or Nathan Grasse (nathangrasse@cunet.carleton.ca). 
