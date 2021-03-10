#!/bin/bash
#
# jason at broken.net
# kid tested, and mother approved

exitcode=1

if [ $# -ne 1 ]; then
   if [ $# -gt 1 ]; then
      echo -e "too many arguments. $# is not 1. Please try again"
   fi
   echo -e "ie. $0 name_of_tone\n"
   echo -e "ie. $0 TelRing.wav\n"
   echo -e "valid tones are located in /var/lib/openrepeater/sounds/courtesy_tones. Take a look\n"
   exit $exitcode
fi

tone=$1


if [ ! -e  "/var/lib/openrepeater/sounds/courtesy_tones/$tone" ]; then
   exitcode=$((Sum=$exitcode+1))
   echo "A courtesy tone by this name does not exist. Please check /var/lib/openrepeater/sounds/courtesy_tones for available tones."
   exit $exitcode
fi

echo update settings set value=\"$tone\" where keyID=\"courtesy\" | sqlite3 /var/lib/openrepeater/db/openrepeater.db

php ./svxlink_update_cli.php
if [ $? -eq 0 ]; then
   echo Successfully updated.
else
   echo php returned an error. I did my best.
fi




