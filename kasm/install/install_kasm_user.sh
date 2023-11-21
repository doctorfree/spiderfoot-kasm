#!/usr/bin/env bash

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
SCRIPT_PATH="$(realpath $SCRIPT_PATH)"

umask 022

# Copy in everything in the kasm user's $HOME
if [ -d $HOME ]; then
  for configdir in ${SCRIPT_PATH}/kasm-user/* ${SCRIPT_PATH}/kasm-user/.??*
  do
    [ "${configdir}" == "${SCRIPT_PATH}/kasm-user/*" ] && continue
    [ "${configdir}" == "${SCRIPT_PATH}/kasm-user/.??*" ] && continue
    cfgdir=$(basename "${configdir}")
    if [ -d "${configdir}" ]; then
      if [ -d $HOME/${cfgdir} ]; then
        tar cf - -C ${SCRIPT_PATH}/kasm-user ${cfgdir} | tar xf - -C $HOME
      else
        cp -a ${configdir} $HOME
      fi
    else
      cp ${configdir} $HOME
    fi
  done
else
  [ -d ${SCRIPT_PATH}/kasm-user ] && {
    cp -a ${SCRIPT_PATH}/kasm-user $HOME
  }
fi
find $HOME -type f | xargs chmod 644
find $HOME -type d | xargs chmod 755
[ -d $HOME/bin ] && find $HOME/bin -type f | xargs chmod 755
[ -d $HOME/.local/bin ] && find $HOME/.local/bin -type f | xargs chmod 755
find $HOME -name \*\.desktop | xargs chmod 755
[ -d $HOME/.cargo/bin ] && chmod 755 $HOME/.cargo/bin/*

chown -R 1000:1000 $HOME/
