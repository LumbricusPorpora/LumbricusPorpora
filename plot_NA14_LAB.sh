#!/bin/bash

# set default
gmt gmtset FONT_ANNOT_PRIMARY 20p,Helvetica
gmt gmtset FONT_ANNOT_SECONDARY 10p,Helvetica
gmt gmtset FONT_LABEL 15p,Helvetica
gmt gmtset MAP_TITLE_OFFSET -0.4c
gmt gmtset MAP_FRAME_TYPE plain
gmt gmtset MAP_FRAME_PEN thicker,black
gmt gmtset MAP_ANNOT_OFFSET_PRIMARY 10p
gmt gmtset MAP_LABEL_OFFSET 10p
gmt gmtset PS_MEDIA A2
gmt gmtset PS_PAGE_ORIENTATION portrait
gmt gmtset COLOR_NAN white
gmt gmtset COLOR_MODEL rgb



# basemap
PS=NA14_LAB.pdf
lab='NA.LAB.txt'
J=M15c
R=-130/-100/45/65

gmt psxy -J$J -R$R -T -K >$PS
gmt psbasemap -J$J -R$R -Bxa20 -Bya10 -BWeNS -P -V -K -Y15c >> $PS

gmt makecpt -T40/245/1 -Cturbo >labco.cpt

#gmt xyz2grd $lab -R -Gtemp.grd -I0.5
#mt grdsample temp.grd -Gtempg.grd -R$R -I0.1 
gmt surface $lab -Gtempgi.grd -R$R -I1km
gmt grdimage tempgi.grd -R -J -Clabco.cpt -K -O >>$PS
 
gmt pscoast -J -R -Dh -Na/2p,150 -P -W0.6p,200 -A15000 -K -O >>$PS
gmt psscale -J -R -DjBC+o11/0+w10/0.4+v+m -Clabco.cpt -Bxa20  -By+l'LAB Depth (km)' -K -O >>$PS

 
gmt psxy RMT.xy -J -R -W1.5,0,-- -K -O >>$PS
gmt psxy CDF.xy -J -R -W3,60,-- -K -O >>$PS



echo complete-
gmt psxy -J -R -T -O >> $PS
rm gmt.*
