chance = 33 
base = balance * 1000e-8
nextbet = base
losecount = 0 
i = balance*0.99
k = 0.0009
roll = 0
target = balance * 1.085
a = 0
resetseed()
function dobet()
    roll+=1
    
    if a==16 then
        bethigh=!bethigh
        --resetseed()
        a=0
    end
    
    if win then
        a+=1
        nextbet=base
        chance=33
        losecount=0
    else
        if balance>target then
            stop()
        end
        nextbet=previousbet*1.56
        losecount+=1
    end
    
    if (losecount>5) then
        nextbet=previousbet*1.56
        chance=10
    end
    
    if (losecount>8) then
        nextbet=previousbet*1.56
        chance=33
    end
    
    if (losecount>10) then
        nextbet=previousbet*1.56
        chance=15
    end
    
    if (losecount>13) then
        nextbet=previousbet*1.88
        chance=41.25
    end
    
    if (losecount>14) then
        nextbet=previousbet*1.88
        chance=20
    end
    
    if (losecount>17) then
        nextbet=previousbet*2.075
        chance=48
    end
    
    if (losecount>18) then
        nextbet=previousbet*2
    end
    
    if (losecount>19) then
        nextbet=previousbet*1.95
    end 
end 

