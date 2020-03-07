#!/usr/bin/env python

"""
Sample code from _Tariq for converting from North Central Texas State Plane
coordinates to WGS84 Long/Lat coordinates.

"""


from pyproj import Proj, transform

inProj = Proj(init='epsg:2276')
outProj = Proj(init='epsg:4326')

x1,y1 = 4636565.411864,446097.654469
x2,y2 = transform(inProj,outProj,x1,y1)

print (x2,y2)
