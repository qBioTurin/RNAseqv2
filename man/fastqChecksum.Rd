% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fastqChecksum.R
\name{fastqChecksum}
\alias{fastqChecksum}
\title{Generating fastq checksum running md5sum}
\usage{
fastqChecksum(input.folder)
}
\arguments{
\item{input.folder, }{a character string indicating the input folder where the fastq files are located.}
}
\value{
md5sum files
}
\description{
This function executes md5sum program to create the checksum for any fastq file in the input folder.
}
\examples{
\dontrun{
    #running rsemstar index for human
    fastqChecksum("~/home/data/input")

}
}
\author{
Marco Beccuti, marco.beccuti [at] unito [dot] it, University of Torino
}
