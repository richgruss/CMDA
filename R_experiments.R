setwd('/Users/rgruss/git/CMDA')

library('RJDBC')

drv <- JDBC("org.h2.Driver", "lib/h2-1.3.176.jar", identifier.quote="'")

conn <- dbConnect(drv, "jdbc:h2://Users/rgruss/git/CMDA/db/h2demodb_h2", "u","p")

d <- dbGetQuery(conn, "SELECT * from example_table")

print(d)

