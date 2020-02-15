#' @title Generating fastq running bcl2fastq
#' @description This function executes the Illumina bcl2fastq program
#' @param samplesheet, a character string indicating the Illumina folder where the Samplesheet.csv is located.
#' @param output.folder, a character string indicating the fastq output folder.
#' @param threadBCL, a number indicating the number of threads to be used for loading BCL data
#' @param threadWritingFastq, a number indicating the number of threads to be used for writing FASTQ data
#' @param threadDem, a number indicating the number of threads to be used for for processing demultiplexed data
#'
#' @return Fastq files
#' @author Marco Beccuti, marco.beccuti [at] unito [dot] it, University of Torino
#' @examples
#'\dontrun{
#'     #running rsemstar index for human
#'     bcl2fastq("~/home/data/input","~/home/data/output")
#'
#' }
#' @export
bcl2fastq <- function(samplesheet,output.folder, threadBCL=1, threadWritingFastq=1, threadDem=6){

  home <- getwd()
  input.folder=dirname(samplesheet)

  if (!file.exists(samplesheet)){
    cat(paste("\nError: the ",samplesheet, " file does not exist.\n"))
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
  params <- paste("--cidfile ", input.folder,"/dockerID -v ", input.folder,":/input -v ",output.folder,":/output -d ", containers.names["bcl2fastq",1],"  bcl2fastq /input /output /input/",basename(samplesheet)," ",threadBCL," ",threadWritingFastq," ",threadDem, sep="")

  cat("\n\n************  Demultiplexing  running   ************\n\n")
  resultRun=dockerRun(params=params)

  if(resultRun==0){
    cat("\n************ Demultiplexing is finished ************\n\n")
  }
  #Running docker


  #Storing ExitSatus
  system("echo 0 > ExitStatusFile 2>&1")

  setwd(home)
  }
