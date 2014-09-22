#!/bin/sh


#  Start a remote x-session at 2.2.2.2
#
# This is just a sample implementation of a slightly less primitive
# interface than xinit.  It looks for user .xinitrc and .xserverrc
# files, then system xinitrc and xserverrc files, else lets xinit choose
# its default.  The system xinitrc should probably do things like check
# for .Xresources files and merge them in, start up a window manager,
# and pop a clock and several xterms.
#
# Site administrators are STRONGLY urged to write nicer versions.
#

unset DBUS_SESSION_BUS_ADDRESS
unset SESSION_MANAGER


userclientrc=$HOME/.xinitrcREMOTE
sysclientrc=/etc/X11/xinit/xinitrc.doesntexist


userserverrc=$HOME/.xserverrc
sysserverrc=/etc/X11/xinit/xserverrc
defaultclient=/usr/bin/urxvtcd
defaultserver=/usr/bin/X
defaultclientargs=""
defaultserverargs=""
defaultdisplay=":0"
clientargs=""
serverargs=""

enable_xauth=1


# Automatically determine an unused $DISPLAY
d=0
while true ; do
    [ -e /tmp/.X$d-lock ] || break
    d=$(($d + 1))
done
defaultdisplay=":$d"
unset d


whoseargs="client"
while [ x"$1" != x ]; do
    case "$1" in
    # '' required to prevent cpp from treating "/*" as a C comment.
    /''*|\./''*)
	if [ "$whoseargs" = "client" ]; then
	    if [ x"$client" = x ] && [ x"$clientargs" = x ]; then
		client="$1"
	    else
		clientargs="$clientargs $1"
	    fi
	else
	    if [ x"$server" = x ] && [ x"$serverargs" = x ]; then
		server="$1"
	    else
		serverargs="$serverargs $1"
	    fi
	fi
	;;
    --)
	whoseargs="server"
	;;
    *)
	if [ "$whoseargs" = "client" ]; then
	    clientargs="$clientargs $1"
	else
	    # display must be the FIRST server argument
	    if [ x"$serverargs" = x ] && \
		 expr "$1" : ':[0-9][0-9]*$' > /dev/null 2>&1; then
		display="$1"
	    else
		serverargs="$serverargs $1"
	    fi
	fi
	;;
    esac
    shift
done

# process client arguments
if [ x"$client" = x ]; then
    client=$defaultclient

    # For compatibility reasons, only use startxrc if there were no client command line arguments
    if [ x"$clientargs" = x ]; then
        if [ -f "$userclientrc" ]; then
            client=$userclientrc
        elif [ -f "$sysclientrc" ]; then
            client=$sysclientrc






        fi
    fi
fi

# if no client arguments, use defaults
if [ x"$clientargs" = x ]; then
    clientargs=$defaultclientargs
fi

# process server arguments
if [ x"$server" = x ]; then
    server=$defaultserver

    # For compatibility reasons, only use xserverrc if there were no server command line arguments
    if [ x"$serverargs" = x -a x"$display" = x ]; then
	if [ -f "$userserverrc" ]; then
	    server=$userserverrc
	elif [ -f "$sysserverrc" ]; then
	    server=$sysserverrc
	fi
    fi
fi

# if no server arguments, use defaults
if [ x"$serverargs" = x ]; then
    serverargs=$defaultserverargs
fi

# if no display, use default
if [ x"$display" = x ]; then
    display=$defaultdisplay
fi

if [ x"$enable_xauth" = x1 ] ; then
    if [ x"$XAUTHORITY" = x ]; then
        XAUTHORITY=$HOME/.Xauthority
        export XAUTHORITY
    fi

    removelist=

    # set up default Xauth info for this machine

    # check for GNU hostname
    if hostname --version > /dev/null 2>&1; then
        if [ -z "`hostname --version 2>&1 | grep GNU`" ]; then
            hostname=`hostname -f`
        fi
    fi

    if [ -z "$hostname" ]; then
        hostname=`hostname`
    fi

    authdisplay=${display:-:0}

    mcookie=`/usr/bin/mcookie`







    if test x"$mcookie" = x; then
        echo "Couldn't create cookie"
        exit 1
    fi
    dummy=0

    # create a file with auth information for the server. ':0' is a dummy.
    xserverauthfile=`mktemp --tmpdir serverauth.XXXXXXXXXX`
    trap "rm -f '$xserverauthfile'" HUP INT QUIT ILL TRAP KILL BUS TERM
    xauth -q -f "$xserverauthfile" << EOF
add :$dummy . $mcookie
EOF




    serverargs=${serverargs}" -auth "${xserverauthfile}


    # now add the same credentials to the client authority file
    # if '$displayname' already exists do not overwrite it as another
    # server man need it. Add them to the '$xserverauthfile' instead.
    for displayname in $authdisplay $hostname$authdisplay; do
        authcookie=`xauth list "$displayname" \
        | sed -n "s/.*$displayname[[:space:]*].*[[:space:]*]//p"` 2>/dev/null;
        if [ "z${authcookie}" = "z" ] ; then
            xauth -q << EOF 
add $displayname . $mcookie
EOF
        removelist="$displayname $removelist"
        else
            dummy=$(($dummy+1));
            xauth -q -f "$xserverauthfile" << EOF
add :$dummy . $authcookie
EOF
        fi
    done
fi












xinit "$client" $clientargs -- "$server" $display $serverargs



retval=$?

if [ x"$enable_xauth" = x1 ] ; then
    if [ x"$removelist" != x ]; then
        xauth remove $removelist
    fi
    if [ x"$xserverauthfile" != x ]; then
        rm -f "$xserverauthfile"
    fi
fi



















exit $retval

