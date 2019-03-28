



for a = 40:10:250
    ShowHysteresisAllAngles(a, a, a, 10, 1)
end

for a = 40:10:250
    ShowHysteresisAllAngles(a, a, a, 10, 10)
end

for d = [1 5 10 20 50 100]
    ShowHysteresisAllAngles(50, 50, 50, d, 10)
end
