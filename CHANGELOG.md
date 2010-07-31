## 0.1 (July 13, 2010)

Features:
  - added generation of dummy data based on a Rails 3 application


## 0.2 (July 17, 2010)

Features:
  - moved data generation into a generator
  - added growth-ratio and base-amount options
  

## 0.3 (July 21, 2010)

Features:
  - added rake task to import the generated dummy data in the target application


## 0.4 (July 24, 2010)

Features:
  - improved data generation (which tries to be smart, RIP lorem ipsum)

  
## 0.5 (July 24, 2010)

Features:
  - added tests for the data generators and rails generator
  - small improvements
  - added documentation
  
Fixes:
  - various minor bugs
  
## 0.5.1 (July 29, 2010)

Fixes:
  - fixed a bug where magic integers were being returned as strings
  
## 0.5.2 (July 30, 2010)

Features:
  - added option to manually configure the amount of records to generate for each model
  
## 0.6 (July 31, 2010)

Features:
  - added option to define the output folder where the YAML files are placed
  
Fixes:
  - Removed unused core extensions (for now)
  - fixed some outdated tests
  

