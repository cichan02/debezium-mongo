HOSTNAME=`hostname`

  OPTS=`getopt -o h: --long hostname: -n 'parse-options' -- "$@"`
  if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

  echo "$OPTS"
  eval set -- "$OPTS"

  while true; do
    case "$1" in
      -h | --hostname )     HOSTNAME=$2;        shift; shift ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
echo "Using HOSTNAME='$HOSTNAME'"

mongosh --host localhost --port 27017 \
        --username=$MONGO_INITDB_ROOT_USERNAME \
        --password=$MONGO_INITDB_ROOT_PASSWORD \
        --authenticationDatabase=admin <<-EOF
    rs.initiate({
        _id: "rs0",
        members: [ { _id: 0, host: "$HOSTNAME:27017" } ]
    });
EOF
echo "Initiated replica set"
