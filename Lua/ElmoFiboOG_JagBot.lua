--[[] 
    Elmo's Fibonacci Betting System
]]--
chance = 49.50
prebet1 = balance * 1000e-8
preroll1 = 3
base = prebet1*2

prebet = prebet1
preroll = preroll1
nextbet = prebet
betlimit = prebet*15
target = balance*1.1
profittarget = balance*1.05
initbalance = balance
losslimit = balance*0.90

firstbet = prebet
secondbet = prebet
temp = 0
bethigh = true
betcount = 0
count = 0
stoploss = balance - (balance*(60/100))

--resetseed()

function dobet()
    betcount += 1
    count += 1
    betlimit = prebet * 200
    e = currentstreak + preroll
    
    if !win and (previousbet > firstbet) then
        secondbet = firstbet
        firstbet = previousbet
    end

    -- <<Bet Randomizer>>
    r = math.random(2)
    if r == 1 then
        bethigh = true
    else
        bethigh = false
    end
    -- <<Bet Randomizer>>

    if betcount == 25 then
        betcount = 0
    end

    if count > 500 then
        --resetseed()
        count = 0
    end

    if balance >= profittarget then
        firstbet = prebet
        secondbet = prebet
        nextbet = prebet
        preroll = preroll1
        base = prebet * preroll
        profittarget = profittarget * 1.20
        losslimit = balance * 0.90
    end

    if balance >= target then
        stop()
    end
    
    if (balance) < (stoploss) then
        stop()
    end
    if losslimit > balance then
        prebet = prebet1 * 2
        base = prebet * 2
        losslimit = balance * 0.90
    else
        prebet = prebet1
        base = prebet * 2
    end

    if balance > initbalance then
        if (balance - initbalance) == 0 then
            nextbet = prebet
        end
    
        if (balance - initbalance) > 0 then
            nextbet = prebet
        end
    
        initbalance = balance
        firstbet = prebet
        secondbet = prebet
    end

    if balance < initbalance then
        if (initbalance - balance) == prebet then
            nextbet = prebet
        end
    
        if (initbalance - balance) == (prebet*2) then
            nextbet = prebet
        end 
    
        if (initbalance - balance) > (prebet*2) then
            nextbet = firstbet + secondbet
        end
    
        if win and (initbalance > balance) then
            nextbet = previousbet
        end
    end

    if !win and e==2 then
        nextbet = previousbet
    end

end --End of Dobet