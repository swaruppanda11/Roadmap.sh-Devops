#!/bin/bash

echo "=================== Service Performance Stats ===================" 
echo "Hostname          : $(hostname)"

print metric() {
    echo -e "${YELLOW}$1:${NC} $2"
}

if [ -f /etc/os-release ]; then
    # Linux
    OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d \")
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    OS="$(sw_vers -productName) $(sw_vers -productVersion)"
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* || "$OSTYPE" == "win32" ]]; then
    # Windows (Git Bash, Cygwin, MSYS)
    OS="Windows ($(cmd.exe /c ver | tr -d '\r'))"
else
    OS="Unknown OS"
fi

echo "OS Version      : $OS"

get_cpu_usage()
echo “CPU Usage:”
ps -A -o %cpu | awk '{s+=$1} END {print s "%"}'
