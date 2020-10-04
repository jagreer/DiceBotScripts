"""
    Dbl_Elmo
"""

# Imports
from browser import document, window
import math, random, sys, time

# Init Globals
bal = float(balance)
chance = 33
basebet = bal * 1000e-8
nextbet = basebet
base2 = basebet
losscount = 0
i = bal * 0.99
k = 0.0009
roll = 0
targetprofit = bal * 1.10
a = 0
bethigh = True
resetvalue = 100
winchance = 33.0
multiplier = 2.1
wintotal = 0
#resetseed() # Live play only

# Sleep function
def sleeper(n=0.5):
    max = n
    start = time.process_time()
    sentry = True
    while (sentry == True):
        remaining = max + start - time.process_time()
       # print("%s seconds remaining" % int(remaining))
        if remaining <= 0:
            break
            
def iloss(chance):
     result = ( chance * 2 + 1 ) / 100
     return(result)
            
def dobet(event):
  	# Init Globals
    # Game variables must always be called as global
    # any user variables initialized outside of 
    # dobet() must be declared global
    global chance,multiplier,bethigh,nextbet
    global previousbet,bets,wins,losses,profit,currentprofit,currentstreak,currentroll,balance,win
    global currency,currencies,lastBet
    global basebet,losscount,winchance,resetvalue,wintotal,resetseed,bal,targetprofit
    
    lossincrease = iloss(chance)
    
    if resetvalue == 100:
        resetvalue = 0
     else:
        resetvalue=resetvalue+1
        wintotal=wintotal+currentprofit
    
    if bal > targetprofit:
        stop()
    
    if (balance < nextbet):
        stop()
    
    if losscount==14:
        chance=49.5
        nextbet= previousbet*1.3
    
    r = random.random(10)
    
    if r >= 5:
        bethigh = true
    else:
        bethigh = False
        
    if win == True:
        if currentstreak > 2:
            nextbet = base2
        else:
            nextbet = base2
            losscount = 0
            chance = winchance
    elif win == False:
        if losscount < 0:
            nextbet = base2
        elif losscount < 2:
            nextbet = base
        else:
            nextbet = previousbet * multiplier
        losscount = losscount + 1
        
    if nextbet >= profit:
        base2 = previousbet * lossincrease + base2
        
    