

### Build a Module

If you are interested in data that is not included in the current build, you can create a new module to add data to the dataset. It is a fairly straight-forward process and does not require a lot of programming knowledge, other than definining the variable list and documenting the definition (990 field) for each variable you create.

* Start with the IRS 990 form or section to identify the variables that you wish to collect.
* Match the variables in the 990 to their xpaths available [HERE](https://www.irs.gov/charities-non-profits/990-990-ez-990-pf-ty2013-v1-0-schema-business-rules-and-release-memo).
* Use the "Xpath to Xpath" file, and the "Updated Xpath to Xpath" files to find the four versions of each variable (one version for the 990PC form, one version for the 990EZ form, and both change between 2012 and 2013).
* The results looking something [LIKE THIS](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Helper_Functions/getBasicInfo.R). 

If you are looking at one specific XML file, you can generate the xpath variable list by running [THIS SCRIPT](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Helper_Functions/generateAllXpaths.R). 

See the [Quick Guide to XML in R](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Quick_Guide_to_XML_in_R.pdf) for more details.

We welcome any contributions!
