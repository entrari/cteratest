#!/bin/bash
if [ -z ${1} ]
then
    echo -e "Uso. ${0} <fichero lista de usuarios y grupos>\n\n"
    exit 1
fi
file=${1}
USERGROUP="users"
cat ${file}| while read -r USER
do
    USERNAME=${USER}
    PASSWORD=$(dd if=/dev/urandom bs=16 count=1 2>/dev/null | uuencode - | head -n 2 | grep -v begin | cut -b 2-10)
    useradd -g ${USERGROUP} -m -d/home/${USERNAME} ${USERNAME}
    echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USERNAME}
    echo -e "{$USERNAME}:${PASSWORD}" >> usuarios
    chage -M 365 ${USERNAME}
    chage -l ${USERNAME}
done
exit 0
