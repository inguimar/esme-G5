#!/bin/bash

### BEGIN INIT INFO
# Provides: esme-gpio26-toggle
# Required-Start: $remote_fs $time
# Required-Stop: $remote_fs $time
# Default-Start: 3 4 5
# Default-Stop: 0 1 2 6
# Short-Description: ESME GPIO#26 toggle service
### END INIT INFO


# Programme et arguments
DAEMON=/usr/bin/esme-3S5-gpio-toggle
DAEMON_NAME=esme-gpio26-toggle
GPIO_ID=26

# Fonction pour démarrer le programme
start() {
    echo "Starting $DAEMON_NAME..."
    start-stop-daemon --start --background --exec $DAEMON -- --gpio $GPIO_ID
    echo "$DAEMON_NAME started."
}

# Fonction pour arrêter le programme
stop() {
    echo "Stopping $DAEMON_NAME..."
    start-stop-daemon --stop --exec $DAEMON
    echo "$DAEMON_NAME stopped."
}

# Fonction pour redémarrer le programme
restart() {
    echo "Restarting $DAEMON_NAME..."
    start-stop-daemon --stop --exec $DAEMON
    start-stop-daemon --start --background --exec $DAEMON -- --gpio $GPIO_ID
    echo "$DAEMON_NAME restarted."
}

# Fonction pour afficher le statut du programme
status() {
    PID=$(pgrep -f "$DAEMON --gpio $GPIO_ID")
    if [ -n "$PID" ]; then
        echo "Status of $DAEMON_NAME for GPIO#$GPIO_ID: running with PID=$PID"
    else
        echo "Status of $DAEMON_NAME for GPIO#$GPIO_ID: stopped"
    fi
}

# Vérification de l'argument fourni
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: esme-gpio26-toggle (start | stop | restart | status)"
        exit 1
        ;;
esac
