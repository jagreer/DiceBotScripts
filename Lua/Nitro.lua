
--[[

      Nitro.lua
      
]]--

chance = math.random(25,25)
basebet = balance * 1000e-8
nextbet = basebet
target = balance * 1.10
bethigh = true
low = 0
high = 0
session = 0
counter = 0
wincount = 0
betcount = 0
losecount = 0
lostchance = 0
--resetseed()
--resetstats()

function dobet()
    rstseed()
    betcount+=1
    
    if (win == true) then
        chance = (math.random()*(33.10-33.00)+8)
        nextbet = basebet
        losecount = 0
    end
    
    if (win == false) then
        losecount += 1
        
        if (losecount > 6) then
            nextbet = previousbet * 4.8
            chance = math.random( 50,50 )
            switcher()
        else
            nextbet = previousbet*1.03
            chance = math.random(25,25)
            switcher()
        end
    end
   sleepf(0.5)
end

-- UTILITY FUNCTIONS
function sleepf(n)
    t0 = os.clock()
    while os.clock() - t0 <= n do end
end

function rstseed()
    
    if counter == 5 then
        --resetseed()
        counter = 0
        low = 0
        high = 0
    else
      counter+=1
    end
    
    if balance > target then
        stop()
    end
    
    if balance < nextbet then
        stop()
    end   
end

function switcher()
    if (bethigh == true) then bethigh = false end
    if (bethigh == false) then bethigh = true end
end