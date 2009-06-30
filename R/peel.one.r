
#peel.one - 

#the main change I made was adding a new quantile function pquantile, that handles
#things more appropriately for PRIMs purposes (see that function).  

`peel.one` <-
function(x, y, box, peel.alpha, mass.min, threshold, d, n)
{
  box.new <- box
  mass <- length(y)/n

  if (is.vector(x)) return(NULL)
  
  y.mean <- mean(y)
  y.mean.peel <- matrix(0, nrow=2, ncol=d)
  box.vol.peel <- matrix(0, nrow=2, ncol=d) 
                     
  for (j in 1:d)
  {
    box.min.new <- pquantile(x[,j], peel.alpha, ptype="lowend")
    box.max.new <- pquantile(x[,j], 1-peel.alpha, ptype="highend")

    y.mean.peel[1,j] <- mean(y[x[,j] >= box.min.new])
    y.mean.peel[2,j] <- mean(y[x[,j] <= box.max.new])

    box.temp1 <- box
    box.temp2 <- box
    if (!is.na(box.min.new)){
      box.temp1[1,j] <- box.min.new
    }
    if (!is.na(box.max.new)){
      box.temp2[2,j] <- box.max.new
    }
    
    box.vol.peel[1,j] <- vol.box(box.temp1)
    box.vol.peel[2,j] <- vol.box(box.temp2)    
  }
  
  y.mean.peel.max.ind <- which(y.mean.peel==max(y.mean.peel, na.rm=TRUE), arr.ind=TRUE)

  ## break ties by choosing box with largest volume

  nrr <- nrow(y.mean.peel.max.ind) 
  if (nrr > 1)
  {
    box.vol.peel2 <- rep(0, nrr)
    for (j in 1:nrr)
      box.vol.peel2[j] <- box.vol.peel[y.mean.peel.max.ind[j,1],
                                       y.mean.peel.max.ind[j,2]]
    
    row.ind <- which(max(box.vol.peel2)==box.vol.peel2)[1] #added 5/28/08 the [1] to deal with ties
  }
  else
    row.ind <- 1
  
  y.mean.peel.max.ind <- y.mean.peel.max.ind[row.ind,]
  ## peel along dimension j.max
  j.max <- y.mean.peel.max.ind[2]

  ## peel lower 
  if (y.mean.peel.max.ind[1]==1)
  {
    box.new[1,j.max] <- pquantile(x[,j.max], peel.alpha, ptype="lowend")
    x.index <- x[,j.max] >= box.new[1,j.max] 
  }
  ## peel upper 
  else if (y.mean.peel.max.ind[1]==2)
  {
    box.new[2,j.max] <- pquantile(x[,j.max], 1-peel.alpha, ptype="highend")
    x.index <- x[,j.max] <= box.new[2,j.max]
  }
 
  x.new <- x[x.index,]
  y.new <- y[x.index]
  mass.new <- length(y.new)/n
  y.mean.new <- mean(y.new)

  ## if min. y mean and min. mass conditions are still true, update
  ## o/w return NULL  

  if ((y.mean.new >= threshold) & (mass.new >= mass.min) & (mass.new < mass) & (y.mean < 1))
    return(list(x=x.new, y=y.new, y.mean=y.mean.new, box=box.new,
                mass=mass.new))
}

