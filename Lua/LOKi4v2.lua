--[[
	LOKi4v2 
	by: JagBot
]]--

-- Sleep function
function sleep(n)
	t0 = os.clock()
	while os.clock() - t0 <= n do end
end

-- Init Globals
basebet = balance * 1000e-8
chance = 50
edge = 0.10
kedge = 1.0
targetprofit = balance * 1.10
profitpct = 1.001 
base2 = basebet
nextbet = base2

--resetstats()
--resetseed()

function dobet()

    if math.random(1, 3) % 2 == 0 then
        bethigh = true
    else
        bethigh = false
    end
	
	chance = math.random(47,51)
	newchance = chance
	edge = 0.15
  	kedge = 1.0
	odds = (100-kedge)/newchance
	multi = odds/(odds-1)
	chance2 = (100-kedge)/odds
	probability = chance2/100
	kellyratio = ((probability*odds) + (probability-1))/odds
	kellybet = basebet * kellyratio
	tg = kellybet
	nextbet = kellybet
	dvdr = 1 / multi

	
	if balance >= targetprofit then
		stop()
	end
	
	if (win) then
		if profit > tg then
			tg = profit * profitpct
			nextbet = base2
		end
		if currentstreak >= 2 then
			nextbet = kellybet
        end
        
		nextbet = math.abs(profit) * edge + base2 --*multi
	end
	
	if (!win) then
		if currentstreak <= -2 then
			nextbet = base2*(dvdr^currentstreak)
		end

		if currentstreak <= -3 then
            if (bethigh == true) then bethigh = false end
            if (bethigh == false) then bethigh = true end
		end
		
		if currentstreak == -1 then
			nextbet = base2*multi
        end
        
		nextbet = previousbet * (chance/22)

		if nextbet >= profit then
			base2 = previousbet * edge + base2
		end
	end
	

	sleep(0.75)
end
