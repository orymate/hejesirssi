#!/bin/sh
sed -e 's/[öőó]/o/g' -e 's/[ŐÓÖ]/O/g' -e 's/[úűü]/u/g' -e 's/[ÚŰÜ]/U/g' -e 's/á/a/g' -e 's/Á/A/g' -e 's/é/e/g' -e 's/É/E/g' -e 's/í/i/g' -e 's/Í/I/g'
