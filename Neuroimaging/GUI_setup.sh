
# https://www.youtube.com/watch?v=Jp58Osb1uFo

# Get correct xauth hostkey before running:
xauthhostkey=`xauth list $DISPLAY | cut -d' ' -f 5`

# Works:
docker run -it --rm --net=host -e "DISPLAY"  ff 
touch .Xauthority
xauth add $DISPLAY . 5ab8e1ab40c6572a4d74f9fe292ccb0a # need to get from xauth list $DISPLAY on host
xauth list $DISPLAY
firefox


# Neuroimaging:
# Get correct xauth hostkey before running:
xauthhostkey=`xauth list $DISPLAY | cut -d' ' -f 5`
echo ${xauthhostkey}

docker run -it --rm --net=host -e "DISPLAY" fgiuste/neuroimaging:freesurfer
xauth add $DISPLAY . 98add7d652a193d1bfa8cad7e830694e # need to get from xauth list $DISPLAY on host
xauth list $DISPLAY
freeview