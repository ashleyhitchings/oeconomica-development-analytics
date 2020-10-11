# oeconomica-development-analytics

Guiding question: How does rural-urban migration affect educational attainment across different age groups in India?

Policy Paper: https://docs.google.com/document/d/1EXEuYn7RDfT_u03zfM7S90B_GB0gvqC0LkIF17qB7yw/edit?usp=sharing

### Data Sources
I scraped data from the website of the Office of the Registrar General & Census Commissioner, India and compiled four different datatables based on two sets of 1991 census tables and two sets of 2001 census datatables:

  - C-2 : Age Sex and Educational Level - All Areas (1991)
  - D-4 (S) : Migrants Classified by Place of Last Residence and Duration of Residence In Place of Enumeration (1991)
  - C-8 : Educational Level by Age and Sex for Population Age 7 and Above (2001)
  - D-4: Migrants Classified by Place of Last Residence, Sex and Duration of Residence in Place of Enumeration (2001)

I selected data for 24 states and 6 union territories (with one, Dadra and Nagar Haveli and Daman and Diu, segmented into two) based on the completeness of the data for those states. The states and union territories excluded are: Chhattisgarh, Jharkhand, Telangana (included within Andhra Pradesh, since data is from before division), Odisha, Uttarakhand (aka. UTTARANCHAL), Jammu and Kashmir (UT), Ladakh (UT).

### Hypotheses

Key outcomes of interest:
  - Within a given year, how do literacy rates and educational attainment compare between rural-urban migrants versus the total state-wide population (segmented by age group)?
  - Over time (1991 to 2001), how have literacy rates and educational attainment between rural-urban migrants and total state-wide populations changed (segmented by age group)?
  - How do different levels of migration (ratio of migrants:total population) correlate with literacy rates and educational attainment within migrant populations across age groups over time?
  - How do different levels of migration (ratio of migrants:total population) correlate with literacy rates and educational attainment within state-wide populations across age groups over time?
  - List of dependent variables:
    - Literacy rates
    - Proportion of primary, secondary, college graduates to total population

### Variable Construction
Rural-urban migration rates were  constructed by dividing the population of migrants who originated from a rural region and migrated to an urban setting by the total population for each state. Literacy rates were  measured by dividing the literate population by the total population for each demographic parameter (e.g. age group, gender, migrant vs. non-migrant). Rates for degrees of educational attainment were computed via this same process; for each level of education, the rate of attainment was calculated by dividing the population of individuals who have attained that level of education by the total population within each state. No imputation for missing data from item non-response at follow-up will be performed. Robustness checks were run to ensure the results are robust to outliers. 

### Outcomes with Limited Variation
The following will limit noise caused by variables with minimal variation:
  - Data taken from two different years
  - Data is taking into account multiple categories of age groups
  - Data is taking into account gender
  - Data is taking into account specific levels of education from primary, secondary, undergraduate, graduate, etc
  - Data is taking into account the category of both origin and destination of migration
  - Data could potentially take into account how long residency occurs for migrants in order to differentiate between categories of migration (e.g. urban to rural)

### Highlighted Visualizations
![Lit Rate by Age](https://raw.githubusercontent.com/ashleyhitchings/oeconomica-development-analytics/main/Key%20Figures/litrate_byage.png) 
![Lit Rate by State](https://raw.githubusercontent.com/ashleyhitchings/oeconomica-development-analytics/main/Key%20Figures/litrate_bystate.png) 
![Lit Rate by Percent Migrants](https://raw.githubusercontent.com/ashleyhitchings/oeconomica-development-analytics/main/Key%20Figures/litrate_permig.png) 
![Lit Rate by Gender](https://raw.githubusercontent.com/ashleyhitchings/oeconomica-development-analytics/main/Key%20Figures/litrate_gender_byage.png) 
![Lit Mig Changes](https://raw.githubusercontent.com/ashleyhitchings/oeconomica-development-analytics/main/Key%20Figures/delta_lit_mig_comparative.png) 
![Mig Lit Mig Changes](https://raw.githubusercontent.com/ashleyhitchings/oeconomica-development-analytics/main/Key%20Figures/delta_miglit_mig_comparative.png) 


