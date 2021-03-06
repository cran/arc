% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/toprules.R
\name{topRules}
\alias{topRules}
\title{Rule Generation}
\usage{
topRules(
  txns,
  appearance = list(),
  target_rule_count = 1000,
  init_support = 0,
  init_conf = 0.5,
  conf_step = 0.05,
  supp_step = 0.05,
  minlen = 2,
  init_maxlen = 3,
  iteration_timeout = 2,
  total_timeout = 100,
  max_iterations = 30,
  trim = TRUE,
  debug = FALSE
)
}
\arguments{
\item{txns}{input transactions.}

\item{appearance}{object named list or APappearance object (refer to arules package)}

\item{target_rule_count}{the main stopping criterion, mining stops when the resulting rule set contains this number of rules.}

\item{init_support}{initial support.}

\item{init_conf}{initial confidence.}

\item{conf_step}{confidence will be changed by steps defined by this parameter.}

\item{supp_step}{support will be changed by steps defined by this parameter.}

\item{minlen}{minimum length of rules, minlen=1 corresponds to rule with empty antecedent and one item in consequent. In general, rules with empty antecedent are not desirable for the subsequent pruning algorithm, therefore the value of this parameter should be set at least to value 2.}

\item{init_maxlen}{maximum length of rules, should be equal or higher than minlen. A higher value may decrease the number of iterations to obtain target_rule_count rules, but it also increases the risk of initial combinatorial explosion and subsequent memory crash of the apriori rule learner.}

\item{iteration_timeout}{maximum number of seconds it should take apriori to obtain rules with current configuration/}

\item{total_timeout}{maximum number of seconds the mining should take.}

\item{max_iterations}{maximum number of iterations.}

\item{trim}{if set to TRUE and more than \code{target_rule_count} is discovered, only first \code{target_rule_count} rules will be returned.}

\item{debug}{boolean indicating whether to output debug messages.}
}
\value{
Returns an object of class rules.
}
\description{
A wrapper for the apriori method from the arules package that iteratively changes mining parameters until a desired number of rules is obtained, all options are exhausted or a preset time limit is reached.
Within the arc package, this function serves as a replacement for the CBA Rule Generation algorithm (Liu et al, 1998) -- without pessimistic pruning -- with general apriori implementation provided by existing fast R package \strong{arules}.
}
\examples{
# Example 1
  utils::data(Adult)
  rules <- topRules(Adult, appearance = list(), target_rule_count = 100,
  init_support = 0.5,init_conf = 0.9, minlen = 1, init_maxlen = 10)

# Example 2
  rules <- topRules(as(discrNumeric(datasets::iris, "Species")$Disc.data,"transactions"),
  getAppearance(datasets::iris,"Species"))

# Example 3
  utils::data(datasets::iris)
  appearance <- list(rhs =  c("Species=setosa", "Species=versicolor",
   "Species=virginica"), default="lhs")
  data <- sapply(datasets::iris,as.factor)
  data <- data.frame(data, check.names=FALSE)
  txns <- as(data,"transactions")
  rules <- topRules(txns, appearance)

}
\references{
Ma, Bing Liu Wynne Hsu Yiming. Integrating classification and association rule mining. Proceedings of the fourth international conference on knowledge discovery and data mining. 1998.
}
\seealso{
\code{\link{prune}}
}
