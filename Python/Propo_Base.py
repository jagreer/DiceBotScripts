"""
	Proportional Betting strategy
	Implemented in Python by: JagBot
	source: https://bot.seuntjie.com/scripts.aspx?id=1131
    Risk: HIGH!
"""

# Imports
from browser import document, window
import math, random, sys, time

# Init Globals
bal = float(balance) # To Do: Ask MyDiceBot why I have to do this
basebet = bal * 1000e-8
#bal = float(balance)
walletOriginal = bal
wallet = walletOriginal
divisor = 100
basebet = wallet/divisor
nextbet = basebet
chance = 15
targetprofit = bal * 1.10
winCounter = 0
loseCounter = 0
pi = 3.14
chvar = 2.03
bethigh = True

#resetseed() # Live play only

# Sleep function
def sleeper(n=1):
    max = n
    start = time.process_time()
    sentry = True
    while (sentry == True):
        remaining = max + start - time.process_time()
       # print("%s seconds remaining" % int(remaining))
        if remaining <= 0:
            break

# Bet Logic
def dobet(event):
  	# Init Globals
    global chance,multiplier,basebet,bethigh,nextbet
    global previousbet,bets,wins,losses,profit,currentprofit,currentstreak,currentroll,balance,win
    global currency,currencies,lastBet
    global winCounter,loseCounter,pi,targetprofit,chvar,divisor,wallet,walletOriginal,resetseed,pi

    # Stop condition
    if balance >= targetprofit:
        stop()
    

    if (wallet <=  walletOriginal * 0.05):
        #sleeper(1)
        wallet = bal * 0.33
        walletOriginal = wallet
        winCounter = 0
        loseCounter = 0
        chance = 15
        bethigh = True
        divisor = 100
        basebet = wallet/divisor
        nextbet = basebet


    # Win condition
    if (win == True):
        
        wallet = wallet + currentprofit

        winCounter = winCounter + 1
        loseCounter = 0
        chance = chance - (winCounter * chvar)
        basebet = wallet / (divisor)

        if (chance < 5):
            chance = 5
        
        if (chance > 33.39):
            chance = 31
    
    # Loss condition
    elif (win == False):

        wallet = wallet - previousbet
        loseCounter = loseCounter + 1  

        chance = random.randint(
            random.randint(5,11), 
            random.randint(10+loseCounter,50)
        ) + (loseCounter * pi)

        x = (random.randint(0,10000)/100)

        if (x < chance):
            pass
        else:
            if bethigh == True:
                bethigh = False
            elif bethigh == False:
                bethigh = True
        
        winCounter = 0

        basebet = wallet /(divisor - loseCounter) + (previousbet * 1.5)
        
        if (basebet > wallet):
            basebet = wallet 
    nextbet = basebet        
    sleeper(n=0.3)