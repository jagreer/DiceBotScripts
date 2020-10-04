--Set Profit Target
target=balance*1.10

--Basebet
base = balance * 1000e-8

--Seed Reset
resetvalue=100

winchance= 33.0
multiplier=2.1

losscount=0 
nextbet=base
wintotal=0
base2 = base
resetseed()

function iloss(chance)
     result = ( chance * 2 + 1 ) / 100
     return(result)
end

function dobet()

     lossincrease = iloss(chance)

     if resetvalue == 100 then
          resetvalue=0
          --resetseed();
     else
          resetvalue=resetvalue+1
          wintotal=wintotal+currentprofit
     end

     if (balance) >= target then
          stop();
     end

     if (balance) < (nextbet) then
          stop();
          print("Insufficient Balance")
     end

     if losscount==14 then
          chance=49.5
          nextbet= previousbet*1.3
     end

     --Randomizer
     r = math.random(10)
     
     if r >= 5 then
          bethigh=true
     else
          bethigh=false
     end

     if win then
          if currentstreak > 2 then
               nextbet = base2
          else
               nextbet=base2
               losscount=0
               chance=winchance
          end
     else
          if losscount < 0 then
               nextbet = base2
          elseif losscount < 2 then
               nextbet = base
          else
               nextbet = previousbet * multiplier
          end
          
          losscount = losscount + 1
     end

     if nextbet >= profit then
          base2 = previousbet * lossincrease + base2
     end
end
