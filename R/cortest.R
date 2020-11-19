#' Cortest
#'
#' @param datasource a dataframe or tibble with at least two columns to be able to correlate.
#' @param var1 character vector for, generally, a constant variable to be correlated with  dependent variables during function call
#' @param var2 character vector for the variable of interest
#' @param interval logical value. By default, **TRUE**. Displays confidence interval on `ggscatter()` plot
#' @param cormethod character vector specifying correlation method. By default, **pearson**. Allows for use of 1 of 3 correlation methods: **pearson, kendall, or spearman**. Tests for association between paired samples.
#' @param na.rm a logical indicating whether missing values should be removed
#' @param verbose a logical indicating whether to use verbose for flow of information
#'
#' @return outputs an `htest` object, which is a list containing information about null and alternative hypotheses, estimated distribution parameters, the test-statistic, the p-value, and optional confidence intervals for distribution parameters.
#' @export
#'
#' @examples cortest(datasource = Date, var2 = "Total_N", cormethod = "pearson", verbose = TRUE)
cortest <- function(datasource,
                    var1 = "CO2Flux",
                    var2,
                    interval = TRUE,
                    cormethod = "pearson",
                    na.rm = TRUE,
                    verbose = FALSE) {


  #make sure datasource is a data frame or tibble
  if(!tibble::is_tibble(datasource) || !is.data.frame(datasource)) {
    stop('You must pass either a data frame or tibble to the datasource parameter')
  } # chose stop() because you shouldn't be passing it 2 vectors, for instance. Best to easily organize in data frame or tibble

  #make sure they enter character string for var1
  if(!rlang::is_character(var1)) {
    stop('You entered ', var1, ' for var1, but need to enter a character string')
  } # chose stop() because the pull function is going to need a string of your column name, ie: variabel name

  #make sure they enter character string for nutrient
  if(!rlang::is_character(var2)) {
    stop('You entered ', var2, ' for var2, but need to enter a character string')
  } # chose stop() because nutrients are not represented by anything else



  ######################
  # SCATTER PLOT PRINTING

  if (verbose) {
    print("Building scatterplot...")
  }

  p <- ggpubr::ggscatter(datasource, x = var1, y = var2,
                 add = "reg.line", conf.int = interval,
                 cor.coef = TRUE, cor.method = cormethod,
                 xlab = var1, ylab = var2)
  print(p)
  ######################

  ######################
  # CORRELATION TEST OBJECT OUTPUT

  if (verbose) {
    print("Processing association between paired samples...")
  }

  res <- stats::cor.test(dplyr::pull(datasource, var1), dplyr::pull(datasource, var2), method = cormethod)
  return(res)

}

