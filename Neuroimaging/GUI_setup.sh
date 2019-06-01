
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
docker run -it --rm --net=host -e "DISPLAY"  ff 
touch .Xauthority
xauth add $DISPLAY . 5ab8e1ab40c6572a4d74f9fe292ccb0a # need to get from xauth list $DISPLAY on host
xauth list $DISPLAY
firefox