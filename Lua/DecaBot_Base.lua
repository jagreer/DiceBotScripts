
basebet = balance / 1024 --balance*10000e-8--
nextbet = basebet
chance  = 97.25
targetprofit = balance * 1.10

function dobet()

    if balance >= targetprofit then
		stop()
	end

    if (!win) then
        -- loss, martingale
        nextbet = previousbet * 2
    else
        -- win, reset
        bethigh = true
        nextbet = balance / 1024
        chance = 97.25
    end
    
    if (lastBet.Roll < 3.3) then
        bethigh = true
        chance = 49.11
    elseif (lastBet.Roll > 96.7) then
        bethigh = false
        chance = 49.11
    end
    
end