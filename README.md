# API for USDA Child Nutrition Database
The USDA Child Nutrition Database (CND) can be a difficult thing to navigate especially if you're not using Access. This provides a self hosted method of getting information from the database through a simple API.

Currently using CN20-7 database. Repo will be updated to CN21 once made available by the USDA.

*Full Documentation coming soon*

## Usage

### Import CND

A SQL version of the CND is located in vendor/releases. A class is available to import all of the data into their respective tables. 
`ImportRelease.perform`

*Note: the CND does include alcholoic beverages. By default, the import class will destroy those items. An option will eventually be available to toggle that functionality*
