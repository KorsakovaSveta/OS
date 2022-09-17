#! usr/bin/bash

gcc "$1.c" -o $2

 ./"$2"
#!/bin/bash

if $(gcc  $1 -o $2); then
    ./$2
else
    echo "Compilation finish with error(s)"
fi