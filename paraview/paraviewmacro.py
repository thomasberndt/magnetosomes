from paraview.simple import *
import os
import math

x = 70
y = 70
z = 70
d = 50
N = 10
a = 9
H = []
Mx = []
Hsw1 = []
Hsw2 = []
sign = []

hysfilename = "D:/magnetosomes/hysteresis/{0}x_{1}y_{2}z_{3}d_{4}N_{5}a.hyst".format(x, y, z, d, N, a)
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


OpenDataFile("D:/magnetosomes/domainstates/{0}x_{1}y_{2}z_{3}d_{4}N/{0}x_{1}y_{2}z_{3}d_{4}N_{5:g}_mT_{6}a_mult.tec".format(x, y, z, d, N, Hsw1, a))

view = CreateRenderView()
Show()
Hide()
view.OrientationAxesVisibility = 0
cam = view.GetActiveCamera()
cam.SetFocalPoint((x+d)*N/2e3,-y/1e3,-z/1e3)
cam.Dolly(5)
cam.Azimuth(-50)
cam.Elevation(20)
hel = Helicity()
helDis = Show(hel)
helDis.Opacity = 0.3
gly = Glyph(hel)
Show(gly)
gly.ScaleFactor = 0.04 * x/100
Render()

view.Background = [1.0, 1.0, 1.0]

try: 
    os.makedirs("D:/magnetosomes/plots/3d/{0}x_{1}y_{2}z_{3}d_{4}N".format(x, y, z, d, N))
except OSError:
    if not os.path.isdir("D:/magnetosomes/plots/3d/{0}x_{1}y_{2}z_{3}d_{4}N".format(x, y, z, d, N)):
        raise

SaveScreenshot("D:/magnetosomes/plots/3d/{0}x_{1}y_{2}z_{3}d_{4}N/{0}x_{1}y_{2}z_{3}d_{4}N_{5:g}_mT_{6}a.png".format(x, y, z, d, N, Hsw1, a), 
    view, ImageResolution=[1994, 910], TransparentBackground=1)