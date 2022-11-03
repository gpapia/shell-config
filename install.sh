#!/usr/bin/env sh

files=".profile .shrc .sh_aliases"

if [ "${1}" = "bash" ]
then
    files="${files} .bash_profile .bashrc .bash_aliases"
else
    echo "Shell '${1}' not recognized" > /dev/stderr
    echo "Install only common shell files" > /dev/stderr
fi

if [ -f "${HOME}/liquidprompt/liquidprompt" ]
then
    files="${files} .liquidpromptrc"
fi

for file in ${files}
do
    if [ -f "${HOME}/${file}" ]
    then
        diff -s "${HOME}/${file}" "${file}"
        if [ $? -eq 1 ]
        then
            cp --backup=t -i "${file}" "${HOME}"
        fi
    else
        cp "${file}" "${HOME}"
    fi
done
