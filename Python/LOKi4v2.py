"""
	LOKi4
	Author: JagBot
    Martingale with kelly bet formula
"""

# Imports
from browser import document, window
import math, random, sys, time

# Init Globals
bal = float(balance) # To Do: Ask MyDiceBot why I have to do this
basebet = bal * 1000e-8
base2 = basebet
nextbet = base2
chance = 50
edge = 0.15
profitpct = 1.001
targetprofit = bal * 1.10
bethigh = False
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

def multip(odds):
    return(odds/(odds-1))
   
def odds(edge, chance):
    return((100-edge)/chance)
    
def calc_chance(edge, odds):
    return((100-edge)/odds)
    
def divider(multiplier):
    return(1/multiplier)
    
def prob_ability(chance_math):
    return(chance_math/100)

def kelly_ratio(odds, probability):
    return(((probability*odds) + (probability - 1))/odds)

def kelly_bet(bet, kelly_ratio):
    return(bet * kelly_ratio)


# Bet Logic
def dobet(event):
  	# Init Globals
    # Game variables must always be called as global
    # any user variables initialized outside of 
    # dobet() must be declared global
    global chance,multiplier,basebet,bethigh,nextbet
    global previousbet,bets,wins,losses,profit,currentprofit,currentstreak,currentroll,balance,win
    global currency,currencies,lastBet
    global base2,edge,profitpct,targetprofit,resetseed,mt
    if random.randint(1, 3) % 2 == 0:
        bethigh = True
    else:
        bethigh = False
    
    mt = 1
    kedge = 1.0
    chance = random.randint(47, 51)
    newchance = chance
    oddsv = odds(kedge, newchance)
    multi = multip(oddsv)
    dvdr = divider(multi)
    chance_calc = calc_chance(kedge, oddsv)
    probability = prob_ability(chance_calc)
    kellyratio = kelly_ratio(oddsv, probability)
    kellybet = kelly_bet(basebet, kellyratio)
    tg = kellybet
    nextbet = kellybet
    
    # Stop condition
    if balance >= targetprofit:
        stop()
        
    # Win condition
    if (win == True):
        if profit > tg:
            tg = profit * profitpct
            nextbet = kellybet
        
        if currentstreak >= 2:
            nextbet = kellybet

        nextbet = abs(profit) * multi * edge + base2
    
    # Loss condition
    if (win == False):
        if currentstreak <= -2:
            nextbet = base2 * (dvdr**currentstreak)
        
        if currentstreak == -1:
			nextbet = base2*multi

        if currentstreak <= -3:
            if bethigh == True:
                bethigh = False
            elif bethigh == False:
                bethigh = True
       
        nextbet = previousbet * (chance / 22)
        
        if nextbet >= profit:
            base2 = previousbet * edge + base2
            
    sleeper(0.2)
