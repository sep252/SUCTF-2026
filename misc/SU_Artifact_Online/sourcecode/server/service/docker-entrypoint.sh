#!/bin/sh

# If a dynamic flag is provided via env, overwrite the static one
if [ "$DASFLAG" ]; then
    echo "$DASFLAG" > /home/flag
    export DASFLAG=no_FLAG
    DASFLAG=no_FLAG
elif [ "$FLAG" ]; then
    echo "$FLAG" > /home/flag
    export FLAG=no_FLAG
    FLAG=no_FLAG
elif [ "$GZCTF_FLAG" ]; then
    echo "$GZCTF_FLAG" > /home/flag
    export GZCTF_FLAG=no_FLAG
    GZCTF_FLAG=no_FLAG
fi

# Ensure permissions (in case dynamic flag overwrote)
chown root:ctf /home/flag
chmod 440 /home/flag

# Start socat with PTY allocation.
# - pty:     allocate a pseudo-terminal for the child process
#            (enables termios / tty.setraw for real-time single-key input)
# - sane:    initialise the PTY to sane defaults (echo on, cooked mode)
#            Python's read_key() toggles raw mode only during coord-select
# - stderr:  also redirect stderr through the connection
# - setsid:  create a new session (proper job control)
# - sigint:  forward SIGINT on Ctrl-C
# - ctty:    make the PTY the controlling terminal
exec socat -T 60 TCP-LISTEN:9999,fork,reuseaddr,max-children=10 \
    EXEC:"python3 -u /home/ctf/server.py",pty,sane,stderr,setsid,sigint,ctty
