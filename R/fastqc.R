#' @title A function to handle a docker containier executing fastqc
#' @description This function executes a fedora docker that produces as output FASTQCstdin_fastqc.html and stdin_fastqc.zip files
#' @param input.folder, a character string indicating the folder where input data are located and where output will be written
#' @param reads, integer value indicating the number of reads to be evaluated. The default value allows user to evalueate upto 1e^9 reads.
#' @author Marco Beccuti, marco.beccuti [at] unito [dot] it, University of Torino
#'
#' @examples
#' \dontrun{
#'     fastqc("fastq_folder")
#' }
#'
#' @export
fastqc <- function(input.folder, reads=1000000000){

  home <- getwd()

  if (!file.exists(input.folder)){
    cat(paste("\nErrore the ",input.folder, " file does not exist.\n"))
    return(1)
  }
  setwd(input.folder)

  #Test docker
  test <- dockerTest()
  if(!test){
    cat("\nERROR: Docker seems not to be installed in your system\n")
    system("echo 10 > ExitStatusFile 2>&1")
    setwd(home)
    return(10)
  }
  #Test docker

  #reading docker image names
  containers.file=paste(path.package(package="RNAseq2"),"/Containers/containersNames.txt",sep="/")
  containers.names=read.table(containers.file,header=T,stringsAsFactors = F)
  #reading docker image names

  #Running docker
  params <- paste("--cidfile ", input.folder,"/dockerID -v ", input.folder,":/input  -d ", containers.names["fastqc",1]," /input ",reads,  sep="")

  cat("\n\n***************   fastq  generation   ***************\n\n")
  resultRun=dockerRun(params=params)

  if(resultRun==0){
    cat("\n************ fastq generation is finished ************\n\n")
  }
  #Running docker

  #Storing ExitSatus
  system("echo 0 > ExitStatusFile 2>&1")

  setwd(home)
}
