## Open Data for Nonprofit Research

This project was created to make existing open data assets easily accessible to nonprofit scholars and researchers. 

The IRS maintains several important nonprofit databases to track the current population of exempt organizations, their annual 990 filings, and organizations that have closed. This data has been released in formats that are not always easy to use - ASCII text files, json files, and XML queries. In order to make the data accessible to the research community, we have created scripts to download data from IRS websites, clean and process it, and export into familiar formats (CSV, Stata, SPSS, etc.).

We have begun the process to catalog and document these resources, and will begin sharing them through the Dataverse Open Data portal:

[NONPROFIT INITIATIVE FOR OPEN DATA (NIOD)](https://dataverse.harvard.edu/dataverse/NIOD)

<br>


# Available Data

We have documented and posted the following open data assets:

<br>

## (1) IRS E-Filer 990 Data 

The IRS has released all nonprofit 990 tax data that has been e-filed through their online system, approximately 60-65% of all 990-PC and 990-EZ filers. It is available for years 2012 to current years with a small set of returns avaialable for 2010 and 2011. The data has been posted as XML files in an [Amazon Web Server (AWS) Cloud Server](https://aws.amazon.com/public-datasets/irs-990/). More details about the data and the push to have it made public are below.

In order to support use of this data, we have converted the XML files into a research database similar to the NCCS Core dataset.

[ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Build_IRS990_E-Filer_Datasets/Data_Dictionary.md) ] [ Link to Dataset ]


#### Liberating the 990 Data

The new IRS 990 data repository that was released in June of 2016 is [hosted on an Amazon S3 Cloud Server](https://aws.amazon.com/public-data-sets/irs-990/). 


The release of the data is an important step in making it open and timely (new data is released every couple of months). However, it is currently in XML format and each 990 return is listed on a separate webpage instead of in a single database. This format can be challenging for scholars to work with.


We have created some tools for translating the XML files into a familiar spreadsheet format. We are currently building scripts for each section of the 990 forms in order to generate separate databases for each year of filers. At this early stage we are focusing on the 990 and 990-EZ forms, although the foundation 990-PF files are also available. Datasets are posted on the Dataverse site listed above.


For some background on the campaigns to open access to IRS data, see these articles and blogs:

* [Liberating 990 Data](http://ssir.org/articles/entry/liberating_990_data): Stanford Social Innovation Review
* [The Nonprofit Data Project Blog](https://www.aspeninstitute.org/programs/program-on-philanthropy-and-social-innovation-psi/nonprofit-data-project-updates/): The Aspen Institute
* [IRS Plans to Begin Releasing Electronically Filed Nonprofit Tax Data](https://philanthropy.com/article/IRS-Plans-to-Begin-Releasing/231265): Chronicle of Philanthropy
* [Mandatory E-Filing: Toward a More Transparent Nonprofit Sector](http://www.urban.org/research/publication/mandatory-e-filing-toward-more-transparent-nonprofit-sector): The Urban Institute
* [Recommendations for Improving the Effectiveness of the 990 Form for Reporting](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/IRS%20ACT%20Report%202015.pdf): Advisory Committee on Tax-Exempt and Government Entities (ACT) Report





#### Useful Information About 990 Data

Form 990: A Guide for Newcomers to Nonprofit Research [ [LINK](http://blog.boardsource.org/blog/form-990-a-guide-for-newcomers-to-nonprofit-research) ]

Example Forms:

* [990](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Form%20990-PC%202015.pdf)
* [990-EZ](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Form%20990-EZ%202015.pdf)
* [990-PF](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Form%20990-PF%202015.pdf)
* [990-N Postcard](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Information%20Needed%20to%20File%20e-Postcard.pdf)

A History of the Tax Exempt Sector: An SOI Perspective [ [LINK](https://www.irs.gov/pub/irs-soi/tehistory.pdf) ]

A Guided Tour of the 990 Form by GuideStar [ [LINK](https://learn.guidestar.org/help/highlights-of-irs-form-990) ]

Revised Form 990: The Evolution of Governance and the Nonprofit World [ [LINK](http://www.thetaxadviser.com/issues/2009/aug/revisedform990theevolutionofgovernanceandthenonprofitworld.html) ]

Wikipedia: History of the 990 [ [LINK](https://en.wikipedia.org/wiki/Form_990#History) ]

* Form 990 was first used for the tax year ending in 1941. It was as a two-page form. Organizations were also required to include a schedule with the names and addresses of payees who had given the organization at least $4,000 during the year.

* The form reached four pages (including instructions) in 1947. In 1976 this was increased to 5.5 pages (including instructions), with 8 pages for Schedule A. By 2000 this was 6 pages for Form 990, 42 pages for instructions, 6 pages for Schedule A, and at least 2 pages for Schedule B. This increase is due to use of a larger font and inclusion of sections that are only required for some organizations.

* Starting in 2000, political organizations were required to file Form 990.

* In June 2007, the IRS released a new Form 990 that requires significant disclosures on corporate governance and boards of directors. These new disclosures are required for all nonprofit filers for the 2009 tax year, with more significant reporting requirements for nonprofits with over $1 million in revenues or $2.5 million in assets.




#### Working with the data on the AWS Platform

Charity Navigator has created an open-source [990 Toolkit](http://990.charitynavigator.org/) that allows you to set up an Amazon EC2 instance and clone the full IRS dataset as a relational database. You can read their press release about the project [here](http://www.charitynavigator.org/index.cfm?bay=content.view&cpid=4669).

You can find some useful scripts here for running queries directly within the cloud and downloading data as CSV files, for example [this github gist](https://gist.github.com/ryankanno/a5da4c6f1f8e0136db9623ae1903d23d#form-990).

There are some forums on using the E-Filer data, for example [this reddit forum](https://www.reddit.com/r/aws/comments/4p772f/how_the_heck_do_i_view_the_990_documents_on/).

<br>






## (2) List of all Current Exempt Organizations (all orgs granted 501(c)(3) status)  


The [IRS Publication 78](https://apps.irs.gov/app/eos/forwardToPub78Download.do) contains a list of all organizations that currently have 501(c)(3) tax exempt status and are in good standing (eligible to receive tax-deductible donations) under IRS code.


[ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_Current_Exempt_Orgs_List.Rmd) ]  [ [Link to Dataset](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/Z4PZOG) ]


<br>


## (3) Business Master File of All Current Exempt Orgs

The [IRS Exempt Organization Business Master File Extract (EO BMF)](https://www.irs.gov/charities-non-profits/exempt-organizations-business-master-file-extract-eo-bmf) contains information on all active nonprofits including basic information about nonprofit location, ruling date (when they were granted tax exempt status), and activities. Note that the NTEE codes are noisy and incomplete. It is recommended to use the NCCS codes instead.

[ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_Business_Master_File.Rmd) ]  [ [Link to Dataset](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ZPHJYA) ]




<br>


## (4) Index of 990, 990-EZ and 990-PF Electronic Filers from 2010 to Present

We provide an R script that builds the INDEX file (not the full dataset) for all IRS E-Filer open data provided on the Amazon Web Server. The index contains a limited number of variables such as nonprofit name, EIN, tax year, form type, and the URL link to the XML form of the 990 return data. This index file allows you to see what is available in the open E-Filer database.

[ [Data Dictionary] ](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_E-Filers_Index.Rmd)  [Link to Dataset]

<br>

## (5) All 990-N Postcard Filers

Most small tax-exempt organizations whose annual gross receipts are normally $50,000 or less can satisfy their annual reporting requirement by electronically submitting Form 990-N if they choose not to file Form 990 or Form 990-EZ instead. Exceptions to this requirement include:

* Organizations that are included in a group return
* Churches, their integrated auxiliaries, and conventions or associations of churches
* Organizations required to file a different return

The Postcard Filers dataset contains close to a million cases from the following years:

 2007 |  2008 |  2009 |  2010 |  2011  | 2012  | 2013  | 2014 |  2015 |  2016 
------|-------|-------|-------|--------|-------|-------|------|-------|-----------
26,969 | 28,704 | 45,846 | 31,734 | 36,457  | 36,779 | 52,202 | 120,831 | 475,084  | 65,211 

<br>

[ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_990N_Postcard_Filers.RMD) ]  [ [Link to Dataset](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ZQMJAL) ]


<br>

## (6) All Organizations with a Revoked 501(c)(.) Status

Nonprofits that fail to file 990 returns for three years have their 501(c)(3) tax exempt status automatically revoked by the IRS. This dataset contains more than 670,000 cases for the following years:

2010 |  2011 |  2012 |  2013 |  2014 |  2015  | 2016
-----|-------|-------|-------|-------|--------|-------
372,717 |  92,360  | 47,506  |  52,111  | 36,973  | 36,935  | 35,046  

<br>

[ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_Revoked_Exempt_Orgs.Rmd) ]  [ [Link to Dataset](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/BETUJF) ]


<br>



### Additional Open Data Resources of Note 

There are some additional interesting sources of nonprofit data that have the potential to be leveraged for future research:

* [Pro Publica Nonprofit Explorer API](https://www.propublica.org/nerds/item/announcing-the-nonprofit-explorer-api)
* [Foundation Center API](http://data.foundationcenter.org/about.html)
* [Guidestar APIs](https://community.guidestar.org/groups/developer)
* [Religious Congregation Data](http://www.thearda.com/archive/browse.asp)
* [Dark Money Given to Nonprofits](http://www.opensecrets.org/dark-money/explore-our-reports.php)



<br/>







## Authors and Contributors

If you are interested in submitting resources or building tools to support nonprofit scholarship please contact Jesse Lecy (jdlecy@syr.edu) or Nathan Grasse (nathangrasse@cunet.carleton.ca).

Special thanks to Francisco Santamarina for his meticulous work decoding the IRS XML documents to translate the data into a useful format and creating the Data Dictionary at the heart of this project.


### Open Science

This project was inspired by the [R Open Science](https://ropensci.org/) initiative, which believes in making data accessible and building tools that help a research community better utilize the data. These scripts are written in the R language because it is a freely-available open-source platform that can be used by anyone. 







