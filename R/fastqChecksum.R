#' @title Generating fastq checksum running md5sum
#' @description This function executes md5sum program to create the checksum for any fastq file in the input folder.
#' @param input.folder, a character string indicating the input folder where the fastq files are located.
#'
#' @return md5sum files
#' @author Marco Beccuti, marco.beccuti [at] unito [dot] it, University of Torino
#' @examples
#'\dontrun{
#'     #running rsemstar index for human
#'     fastqChecksum("~/home/data/input")
#'
#' }
#' @export
fastqChecksum<-function(input.folder){

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
  params <- paste("--cidfile ", input.folder,"/dockerID -v ", input.folder,":/input  -d ", containers.names["bcl2fastq",1]," md5sum /input",  sep="")

  cat("\n\n***************   Checksum  generation   ***************\n\n")
  resultRun=dockerRun(params=params)

  if(resultRun==0){
    cat("\n************ Checksum generation is finished ************\n\n")
  }
  #Running docker

  #Storing ExitSatus
  system("echo 0 > ExitStatusFile 2>&1")

  setwd(home)
}
