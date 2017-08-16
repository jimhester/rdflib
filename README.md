
<!-- README.md is generated from README.Rmd. Please edit that file -->
rdflib
======

A friendly and consise user interface for performing common tasks on rdf data, such as parsing and converting between formats including rdfxml, turtle, nquads, ntriples, and trig, creating rdf graphs, and performing SPARQL queries. This package wraps the redland R package which provides direct bindings to the redland C library. This interface takes inspiration from the Python rdflib library.

Installation
------------

You can install rdflib from github with:

``` r
# install.packages("devtools")
devtools::install_github("cboettig/rdflib")
```

Basic use
---------

While not required, `rdflib` is designed to play nicely with `%>%` pipes, so we will load the `magrittr` package as well:

``` r
library(magrittr)
library(rdflib)
```

Parse a file and serialize into a different format:

``` r
system.file("extdata", "dc.rdf", package="redland") %>%
  parse_rdf() %>%
  serialize("test.nquads", "nquads")
```

Perform SPARQL queries:

``` r
file <- system.file("extdata", "dc.rdf", package="redland")

sparql <-
 'PREFIX dc: <http://purl.org/dc/elements/1.1/>
  SELECT ?a ?c
  WHERE { ?a dc:creator ?c . }'

rdf <- parse_rdf(file)
rdf %>% query(sparql)
#> $a
#> [1] "<http://www.dajobe.org/>"
#> 
#> $c
#> [1] "\"Dave Beckett\""
```

Initialize graph a new object or add triples statements to an existing graph:

``` r
x <- rdf()
x <- add(x, 
    subject="http://www.dajobe.org/",
    predicate="http://purl.org/dc/elements/1.1/language",
    object="en")
```

JSON-LD
-------

We can also work with the JSON-LD format through additional functions provided in the R package, `jsonld`. Note that at the time of writing, jsonld-rdf interface supports only the `nquads` serialization format.

``` r
library(jsonld)

tmp <- tempfile()
serialize(x, tmp, "nquads")

str <- readLines(tmp) %>% jsonld_from_rdf() 
str
#> [
#>   {
#>     "@id": "http://www.dajobe.org/",
#>     "http://purl.org/dc/elements/1.1/language": [
#>       {
#>         "@value": "en"
#>       }
#>     ]
#>   }
#> ]
```

Likewise, we can convert JSON-LD data into an RDF model, on which we can then perform SPARQL queries, add triples, or serialize into other formats.

``` r
tmp <- tempfile()
str %>% jsonld_to_rdf() %>% writeLines(tmp)
rdf <- parse_rdf(tmp, format = "nquads")
```

For more information on the JSON-LD RDF API, see <https://json-ld.org/spec/latest/json-ld-rdf/>.