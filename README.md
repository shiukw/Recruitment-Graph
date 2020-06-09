# recruitment_graph
R code for creating a recruitment graph for your research study

READ ME ON HOW TO SET UP YOUR DATA IN THE CSV FILES SO THAT THE R CODE WORKS:

The R code uses information from the two .csv files below:

// recruitmenttotal.csv //
Column A (type) distiniguishes between numbers that were expected (e.g., based on protocol) and observed (i.e., what you actually recruited)
Column B (date) is simply the month of recruitment; presently it is in MMM-YY but you can change it to the full spelling of the month if you want. But the shortform keeps things tidy
Column C (n) is the number of participants recruited during the month

The R code also allows for situations where e.g. your observed recruitment extends far beyond the expected recruitment period.
In this example, you can just simply add new rows and give them the "Observed" type, the months of recruitment, and the recruitment numbers.

// recruitmentsite.csv //
Column A (type) has 3 + i unique categories, where i is the number of recruitment sites in your study:
 - target recruitment is the cumulative targetted recruitment
 - actual recruitment is the cumulative observed recruitment
 - monthly recruitment has the same values as Column C in recruitmenttotal.csv for the "Observed"
 - Site A - I: the monthly recruitment numbers are stratified into their specific site contributions
Column B (date) is simply the month of recruitment; presently it is in MMM-YY
Column C is the number of participants
