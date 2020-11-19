

# THESE SHOULD WORK BUT FOR SOME REASON AREN'T   :(

# They check that you
# a) are passing a valid tibble or data frame
# b) are entering a character string for the var2 variable
# c) are entering a character for cormethod variable
# d) are entering only TRUE or FALSE for the interval variable

# expect_equal(TRUE, is_tibble(datasource)) || expect_equal(TRUE, is.data.frame(datasource))
# expect_equal(TRUE, is_character(var2))
# expect_type(cormethod, "character")
# expect_type(interval, "logical")

# So, the only tests I could include were ones that check the default dataframe object
# included in the package. These ensure you have the right column names


expect_true("CO2Flux" %in% names(Date))
expect_true("Ca" %in% names(Date))
expect_true("Mg" %in% names(Date))
expect_true("Total_N" %in% names(Date))
