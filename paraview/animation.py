from paraview.simple import *
import os
import math

x = float(sys.argv[1])
y = float(sys.argv[2])
z = float(sys.argv[3])
d = float(sys.argv[4])
N = float(sys.argv[5])
a = float(sys.argv[6])
H = []
Mx = []
Hsw1 = []
Hsw2 = []
sign = []

LoadPlugin("D:/magnetosomes/MERRILL-plugins.xml", ns=globals())

hysfilename = "D:/magnetosomes/hysteresis/{0:g}x_{1:g}y_{2:g}z_{3:g}d_{4:g}N_{5:g}a.hyst".format(x, y, z, d, N, a)
with open(hysfilename, 'r') as hysfile:
    next(hysfile,None)
    for row in hysfile:
        val = row.split()
        H.append(float(val[1])*1e3)
        Mx.append(float(val[2]))
        if sign==[]:
            sign = float(val[2])*1e3
        elif sign * float(val[2]) <= 0 and Hsw2==[]:
            Hsw1 = H[-2]
            Hsw2 = H[-1]


view = CreateRenderView()
view.ViewSize = [1500, 1000]
view.OrientationAxesVisibility = 0
view.Background = [1.0, 1.0, 1.0]
cam = view.GetActiveCamera()
cam.SetFocalPoint((x+d)*N/2e3,-y/1e3,-z/1e3)

cam.Azimuth(-50)
cam.Elevation(20)

iszoomed = False
i = 1

for h in H:
	mydata = OpenDataFile("D:/magnetosomes/domainstates/{0:g}x_{1:g}y_{2:g}z_{3:g}d_{4:g}N/{0:g}x_{1:g}y_{2:g}z_{3:g}d_{4:g}N_{5:g}_mT_{6:g}a_mult.tec".format(x, y, z, d, N, h, a))

	Show()
	Hide()
	
	hel = Helicity(mydata)
	helDis = Show(hel)
	helDis.Opacity = 0.3
	gly = Glyph(hel)
	Show(gly)
	gly.ScaleFactor = 0.04 * y/100
		
	Render()

	if not iszoomed:
		cam.Dolly(1.5)
		iszoomed = True

	try: 
		os.makedirs("D:/magnetosomes/plots/3d/{0:g}x_{1:g}y_{2:g}z_{3:g}d_{4:g}N_{5:g}a".format(x, y, z, d, N, a))
	except OSError:
		if not os.path.isdir("D:/magnetosomes/plots/3d/{0:g}x_{1:g}y_{2:g}z_{3:g}d_{4:g}N_{5:g}a".format(x, y, z, d, N, a)):
			raise

	SaveScreenshot("D:/magnetosomes/plots/3d/{0:g}x_{1:g}y_{2:g}z_{3:g}d_{4:g}N_{6:g}a/{7:03d}_{0:g}x_{1:g}y_{2:g}z_{3:g}d_{4:g}N_{5:g}_mT_{6:g}a.png".format(x, y, z, d, N, h, a, i), 
		view, ImageResolution=[1500, 1000], TransparentBackground=1)
		
	
	Delete(gly)
	Delete(helDis)
	Delete(hel)
	Delete(mydata)
	i = i + 1