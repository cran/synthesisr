% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_refs.R
\name{read_refs}
\alias{read_refs}
\alias{read_ref}
\title{Import bibliographic search results}
\usage{
read_refs(
  filename,
  tag_naming = "best_guess",
  return_df = TRUE,
  verbose = FALSE
)

read_ref(
  filename,
  tag_naming = "best_guess",
  return_df = TRUE,
  verbose = FALSE
)
}
\arguments{
\item{filename}{A path to a filename or vector of filenames containing search results to import.}

\item{tag_naming}{Either a length-1 character stating how should ris tags be replaced (see details for a list of options), or an object inheriting from class \code{data.frame} containing user-defined replacement tags.}

\item{return_df}{If TRUE (default), returns a data.frame; if FALSE, returns a list.}

\item{verbose}{If TRUE, prints status updates (defaults to FALSE).}
}
\value{
Returns a data.frame or list of assembled search results.
}
\description{
Imports common bibliographic reference formats (i.e. .bib, .ris, or .txt).
}
\details{
The default for argument \code{tag_naming} is \code{"best_guess"}, which estimates what database has been used for ris tag replacement, then fills any gaps with generic tags. Any tags missing from the database (i.e. \code{code_lookup}) are passed unchanged. Other options are to use tags from Web of Science (\code{"wos"}), Scopus (\code{"scopus"}), Ovid (\code{"ovid"}) or Academic Search Premier (\code{"asp"}). If a \code{data.frame} is given, then it must contain two columns: \code{"code"} listing the original tags in the source document, and \code{"field"} listing the replacement column/tag names. The \code{data.frame} may optionally include a third column named \code{"order"}, which specifies the order of columns in the resulting \code{data.frame}; otherwise this will be taken as the row order. Finally, passing \code{"none"} to \code{replace_tags} suppresses tag replacement.
}
\section{Functions}{
\itemize{
\item \code{read_ref}: Import a single file
}}

\examples{
litsearchr <- c(
  "@article{grames2019,
  title={An automated approach to identifying search terms for
  systematic reviews using keyword co-occurrence networks},
  author={Grames, Eliza M and Stillman, Andrew N and Tingley, Morgan W and Elphick, Chris S},
  journal={Methods in Ecology and Evolution},
  volume={10},
  number={10},
  pages={1645--1654},
  year={2019},
  publisher={Wiley Online Library}
}"
)

tmp <- tempfile()

writeLines(litsearchr, tmp)

df <- read_refs(tmp, return_df = TRUE, verbose = TRUE)
}
