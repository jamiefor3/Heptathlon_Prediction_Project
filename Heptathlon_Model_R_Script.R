#Set Working Directory and read the csv
setwd("C:/Users/ITZJA/OneDrive/Documents/Heptathlon_Prediction_Project")
Data = read.csv("Heptathlon Data.csv", header = TRUE, stringsAsFactors = FALSE)


# Set up table for the models to store intercept, and slope
Zero7 = array(0, dim = c(7))
D.Model = data.frame(correlation = Zero7,
                     intercept = Zero7,
                     slope = Zero7)

# Initialise a data structures to save the "quintiles"
# 7 disciplines x 4 quintile division points
Quintile = matrix(c(0),7,4)

# Initialise the data structure to store the residual values
# 198 previous performances x 7 disciplines
Residual = matrix(c(0),198,7)

# Model Year to Year change in each discipline

for (disc in 1:7) {
  if (disc == 1) {
    # 100m Hurdles
    x = Data$PRE_100mH
    y = Data$DIFF_100mH
  } else if (disc == 2) {
    # High Jump
    x = Data$PRE_HJ
    y = Data$DIFF_HJ   
  } else if (disc == 3) {
    # Shot Put
    x = Data$PRE_Shot
    y = Data$DIFF_Shot     
  } else if (disc == 4) {
    # 200m
    x = Data$PRE_200m
    y = Data$DIFF_200m     
  } else if (disc == 5) {
    # Long Jump
    x = Data$PRE_LJ
    y = Data$DIFF_LJ  
  } else if (disc == 6) {
    # Javelin
    x = Data$PRE_Jav
    y = Data$DIFF_Jav   
  } else if (disc == 7) {
    # 800m
    x = Data$PRE_800m
    y = Data$DIFF_800m    
  }
  
  plot(y~x, ylab = "Change", xlab = "Previous score", axes = TRUE)
  
  r = cor(x,y)
  model = lm(y~x)
  abline(model, col="red")
  
  intercept = model$coefficients[1]
  slope = model$coefficients[2]
  
  # Get the residual values for the current discipline
  Table = data.frame(pred = model$fitted.values, res = model$residuals, absres = abs(model$residuals))
  SortedTable = Table[with(Table, order(pred)), ]

  # Determine the 4 values that split the predicted values into 5 quintiles
  # These will be used to select quintile of residuals to be used during
  # predictive modelling  
  # These division points are halfway between end of one quintile and 
  # start of the next
  Quintile[disc,1] = (SortedTable$pred[39] + SortedTable$pred[40])/2
  Quintile[disc,2] = (SortedTable$pred[79] + SortedTable$pred[80])/2
  Quintile[disc,3] = (SortedTable$pred[118] + SortedTable$pred[119])/2
  Quintile[disc,4] = (SortedTable$pred[158] + SortedTable$pred[159])/2
  
  # Save the residuals
  Residual[,disc] = SortedTable$res
  
  D.Model$correlation[disc] = r
  D.Model$intercept[disc] = intercept
  D.Model$slope[disc] = slope
}

# Hanna Kasyanova scores
Athlete.Pre = c(1047, 978, 739, 947, 975, 589, 890)

# We will do 10,000 simulations - note discipline 8 is the total points
Sim.Points = matrix(c(0),100000,8)

for (sim in 1:100000) {
  # Simulate each discipline
  for (disc in 1:7) {
    # Start with previous year's points
    pts = Athlete.Pre[disc]
    # Determine predicted change
    pred.change = D.Model$intercept[disc] + D.Model$slope[disc]*pts
    # Determine the lower and upper bound of the residual table to
    # be used.  This depends on which quintile the predicted change
    # value is in
    if (pred.change < Quintile[disc,1]) {
      # First quintile
      Lower.bound = 39
      Upper.bound = 40
    } else if (pred.change < Quintile[disc,2]) {
      # Second quintile
      Lower.bound = 79
      Upper.bound = 80
    } else if (pred.change < Quintile[disc,3]) {
      # Third quintile
      Lower.bound = 118
      Upper.bound = 119
    } else if (pred.change < Quintile[disc,4]) {
      # Fourth quintile
      Lower.bound = 158
      Upper.bound = 159
    } else {
      # Fifth quintile
      Lower.bound = 197
      Upper.bound = 198
    }
    
    # Choose a random residual for the quintile of the predicted value
    rand.num = sample(Lower.bound:Upper.bound, 1)
    res.athlete = Residual[rand.num, disc]
    
    # Add up the points
    sim.pts = pts + pred.change + res.athlete
    sim.pts = round(sim.pts, digits = 0)
    Sim.Points[sim,disc] = sim.pts
    Sim.Points[sim,8] = Sim.Points[sim,8] + sim.pts
  }
}

hist(Sim.Points[,8])


# Now to determine which discipline to emphasise
# We will roll the dice twice for the discipline we are emphasising
# and choose the higher of the two residuals
Athlete.Score = array(0, dim = c(8))
for (emph in 1:8) {
  Sim.Points = matrix(c(0),100000,8)
  
  for (sim in 1:100000) {
    # Simulate each discipline
    for (disc in 1:7) {
      # Start with previous year's points
      pts = Athlete.Pre[disc]
      # Determine predicted change
      pred.change = D.Model$intercept[disc] + D.Model$slope[disc]*pts
      # Determine the lower and upper bound of the residual table to
      # be used.  This depends on which qunitile the predicted change
      # value is in
      if (pred.change < Quintile[disc,1]) {
        # First quintile
        Lower.bound = 39
        Upper.bound = 40
      } else if (pred.change < Quintile[disc,2]) {
        # Second quintile
        Lower.bound = 79
        Upper.bound = 80
      } else if (pred.change < Quintile[disc,3]) {
        # Third quintile
        Lower.bound = 118
        Upper.bound = 119
      } else if (pred.change < Quintile[disc,4]) {
        # Fourth quintile
        Lower.bound = 158
        Upper.bound = 159
      } else {
        # Fifth quintile
        Lower.bound = 197
        Upper.bound = 198
      }
      
      if (disc == emph) {
        # Choose the highest of two randomly chosen residuals for the
        # quintile of the predicted value for year to year change
        rand.num = sample(Lower.bound:Upper.bound, 1)
        res.athlete.1 = Residual[rand.num, disc]
        rand.num = sample(Lower.bound:Upper.bound, 1)
        res.athlete.2 = Residual[rand.num, disc]
        res.athlete = max(res.athlete.1, res.athlete.2)
      } else {
        # Choose a random residual for the quintile of the predicted value
        rand.num = sample(Lower.bound:Upper.bound, 1)
        res.athlete = Residual[rand.num, disc]
      }
      # Add up the points
      sim.pts = pts + pred.change + res.athlete
      sim.pts = round(sim.pts, digits = 0)
      Sim.Points[sim,disc] = sim.pts
      Sim.Points[sim,8] = Sim.Points[sim,8] + sim.pts      
    }
  }
  Athlete.Score[emph] = mean(Sim.Points[,8])
}
plot(Athlete.Score)

print(Athlete.Score)