chance    = 32
base      = balance * 1000e-8
nextbet   = base
losecount = 0
target    = balance * 1.10
a         = 0
i = balance*0.99
k = 0.0005
roll = 0

function dobet()
    roll+=1
    
    if balance > target then stop() end
    
    if a==16 then
    	if (bethigh == true) then bethigh = false end
            if (bethigh == false) then bethigh = true end
        --resetseed()
        a=0
    end
    
    if win then
        a+=1
        nextbet = base
        chance = 20
        losecount = 0
    else
        nextbet = previousbet*1.33
        losecount+=1
    end

    if (losecount >= 6) then
        nextbet = previousbet*1.33
        chance = 6
    end
    
    if (losecount >= 10) then
        nextbet = previousbet*1.33
        chance = 20
    end
    
    if (losecount >= 12) then
        nextbet = previousbet*1.33
        chance = 8
    end
    
    if (losecount >= 16) then
        nextbet = previousbet*1.55
        chance = 28
    end
    
    if ( losecount >= 18) then
        nextbet=previousbet*1.5
        chance = 13
    end
    
    if ( losecount >= 19) then
        nextbet=previousbet*1.51
        chance = 14.3
    end
    
    if ( losecount >= 20) then
        nextbet=previousbet*1.53
        chance = 15.5
    end
    
    if ( losecount >= 21) then
        nextbet=previousbet*1.56
        chance = 16.2
    end
    
    if ( losecount >= 22) then
        nextbet=previousbet*1.56
        chance = 16.68
    end
    
    if ( losecount >= 23) then
        nextbet=previousbet*1.56
        chance = 17.18
    end
    
    if ( losecount >= 25) then
        nextbet = previousbet*1.65
        chance = 36
    end
end
