
#quantile finding function that deals with repeated values in a way that 
#is appropriate for PRIM as described below

pquantile <- function(x,alpha,ptype){

#for PRIM, if the quantile is in between identical values, need to narrow it
#means raising threshold for low end, lowering for high end
#ptype indicates this

#alpha patience/quantile parameter
  
  N <- length(x)                           
  
  xs <- sort(x)
  
  intm <- alpha*N
  
  pthresh <- .5*(xs[floor(intm)]+xs[ceiling(intm)])   #prelim threshhold
  
  #check for lots o discrete values
  
  if (xs[floor(intm)]==xs[ceiling(intm)]){ #then may run into problems, so deal with them
    
    if (!(floor(intm) <= 1 | ceiling(intm) >= N))#{pthresh <- NA; return(pthresh)}
  
    if (ptype=="lowend"){ #keep raising index up
  
      if (xs[floor(intm)] == xs[floor(intm)-1]){ 
        # means have repeated values at the quantile messing up pasting until number is different
         
        i <- ceiling(intm)
        
        while ((i<=N) & (xs[i]==xs[i-1])){
          i <- i+1
        }
        
        if(i <= N){
          pthresh <- .5*(xs[i] + xs[i-1])
        } else {pthresh <- NA}
      }
    }
  
    if (ptype=="highend"){# keep lowering index until number is different
      
      if (xs[floor(intm)] == xs[floor(intm)+1]){ 
        # means have repeated values at the quantile messing up pasting until number is different
      
        i <- floor(intm)
        
        while ((i > 1) & (xs[i]==xs[i+1])){
          i <- i-1
        }
        
        if (i > 0){
          pthresh <- .5*(xs[i] + xs[i+1])
        } else {pthresh <- NA}
      }
    }
  }

#just a debugging line:
# if(length(pthresh)==0){print(x);return(x)}
  return(pthresh)

}











