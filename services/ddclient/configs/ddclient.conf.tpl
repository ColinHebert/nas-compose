daemon=300              # check every 300 seconds
syslog=yes              # log update msgs to syslog
pid=/var/run/ddclient/ddclient.pid # record PID in file.
ssl=yes                 # use ssl-support.  Works with
                        # ssl-library
postscript=/data/postscript_gotify.sh # run script after updating.  The
                        # new IP is added as argument.
use=web
web=googledomains

##
## CloudFlare (www.cloudflare.com)
##
protocol=cloudflare,       \
zone=dedicated.contact,    \
ttl=1,                     \
login=token,               \
password=$CLOUDFLARE_TOKEN \
$CLOUDFLARE_DOMAIN
