% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as_rdf.R
\name{as_rdf}
\alias{as_rdf}
\title{Coerce an object into RDF}
\usage{
as_rdf(x, rdf = NULL, prefix = NULL, base = getOption("rdf_base_uri",
  "localhost://"), context = NULL, key_column = NULL)
}
\arguments{
\item{x}{an object to coerce into RDF (list, list-like, or data.frame)}

\item{rdf}{An existing rdf object, (by default a new object will be initialized)}

\item{prefix}{A default vocabulary (URI prefix) to assume for all predicates}

\item{base}{A base URI to assume for blank subject nodes}

\item{context}{a named list mapping any string to a URI}

\item{key_column}{name of a column which should be
treated as the primary key in a table. must be unique}
}
\description{
Coerce an object into RDF
}
\examples{
as_rdf(mtcars)
as_rdf(list(repo = "rdflib", owner = list("id", "ropensci")))
}
