-----if you enjoy this script, please consider tipping Seuntjie then myself.
-----my wallet addresses are below
-----BTC = ""
-----LTC = ""
-----DOGE = ""
-----ETHER = ""
----------------------------------------------------------
---------n-------------------------------------------------
function sleepf(n)
    t0 = os.clock()
    while os.clock() - t0 <= n do end
end

print("Activated with ") 
print(nCur)

--set targets
amount=3100              -- Amount to withdraw
profittarget= 11000      -- Set max Balance to start withdraw
stoptarget=balance * -(1.80)         -- Set min Balance to stop script
 
--set your withdrawal amounts and triggers below
if (nCur == "btc")
then 
    --btc
    amount = 0.0011
    profittarget = balance * 1.10
    stoptarget = balance * -(1.80)
elseif (nCur == "ltc")
then
    --ltc
    amount = 0.008
    profittarget = balance * 1.10
    stoptarget = balance * -(1.80)
elseif (nCur == "doge")
then
    --doge
    amount = 16000
    profittarget = balance * 1.10
    stoptarget = balance * -(1.80)
else
    --eth
    amount = 0.29
    profittarget = balance * 1.10
    stoptarget = balance * -(1.80)
end

winCounter = 0
loseCounter = 0
--this is just the initial chance, set it to whatever you want
chance = 15
bethigh = true
--the divisor is the fraction split set onto the wallet, 77 works for me
divisor = 100


--you can type "stoponwin = true" in the console window while it's running to stop on the next win
stoponwin = false

-- JagBot: Truncated these constants to 2 digits
PI = 3.14 -- 3.14159
chncvar = 2.03 -- 2.030917
printWallet = 0
walletOriginal = balance
wallet = walletOriginal
basebet = wallet/divisor
target = balance * 1.10471817
nextbet = basebet
function dobet()
    --sites like Primedice get mad if you send too many requests too fast, adjust this sleep timer
    --accordingly. sleep(n) where n is the number of seconds
    sleepf(0.7)
    --check to see if your balance exceeds the profittarget to trigger a withdrawal
    --we want a minimum bet of at least 1 satoshi
    if(basebet < 0.00000010) then basebet = 0.00000001 end
    
    if balance >= target then
        print("Target reached...")
        stop()
    end

    --if your current wallet is less than 5% of the original wallet balance,
    --we reset the values and give the bot a 30 second rest
    --It's entirely speculation but I found a little bit of rest from the betting
    --thread to be helpful (even if just for the user and not the bot)
    
    if(wallet <=  walletOriginal * 0.05)
    then
        print("sleeping")
        sleep(5)
        wallet =  balance * 0.33
        walletOriginal = wallet
        winCounter = 0
        loseCounter = 0
        chance = 15
        bethigh = true
        divisor = 100
        basebet = wallet/divisor
        nextbet = basebet
        stoponwin = false
    end
    
    if (win) then
        --this just adjusts the wallet
        wallet = wallet + currentprofit
        
        if(stoponwin)
        then 
            stop()
        end
        
        winCounter = winCounter + 1
        loseCounter = 0
        chance = chance - (winCounter * chncvar)
        basebet = wallet/(divisor) 
        
        --I like to keep the win chance within a certain range,
        --so if the chance is greater than 33.39 on a win, we reset it to 31 and allow it to
        --crawl down again
        if (chance < 5)
        then
            chance = 5
        end
        
        if (chance > 33.39)
        then
            chance = 31 
        end
    
    elseif (win == false) then
        
        wallet = wallet - previousbet
        loseCounter = loseCounter + 1
        
        --I didn't like balances being killed by deathseeds so I randomized the chance parameter with some --controls
        chance = math.random(
            math.random(5,11), 
            math.random(10+loseCounter,50)
        ) + (loseCounter * PI)
        
        --seed resets and bethigh toggles are random based on the chance percentage
        x = (math.random(0,10000)/100)
        
        if (x < chance)
        then
            --resetseed()
            
        else
            bethigh = !bethigh
        end
	
		winCounter = 0

		basebet = wallet/(divisor - loseCounter) + (previousbet *1.5)
	
		
		if (basebet > wallet) 
		then 
			basebet = wallet 
		end
				
	end

	--again, let's have at least 1 satoshi to bet
	if (basebet < 0.000000015) 
	then 
		basebet = 0.00000001 
		chance = 45.7
	end	
	
	nextbet = basebet


		 
	if balance <= stoptarget then
		stop()
	end
		 
		

end
