#!/usr/bin/env sh

files=".profile .shrc .sh_aliases"

if [ "${1}" = "bash" ]
then
    files="${files} .bash_profile .bashrc .bash_aliases"
else
    echo "Shell '${1}' not recognized" > /dev/stderr
    echo "Install only common shell files" > /dev/stderr
fi

for file in ${files}; do
    cp -i "${file}" "${HOME}"
done

if [ -f "${HOME}/liquidprompt/liquidprompt" ]
then
     cp -i ./.liquidpromptrc "${HOME}"
fi
