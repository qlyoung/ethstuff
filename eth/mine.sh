#!/usr/bin/fish

if not which ethminer
	echo "Couldn't find ethminer executable"
	exit 1
end

# apply overclock
systemctl restart lightdm
for gpu in (seq 0 5)
	nvidia-settings -c :0 -a "[gpu:$gpu]/GPUMemoryTransferRateOffset[3]=1000"
	nvidia-settings -c :0 -a "[gpu:$gpu]/GPUGraphicsClockOffset[3]=100"
end

# start ethminer
set sessionid (random)
tmux new-session -d -s "ethminer$sessionid" ethminer --farm-recheck 200 -U -FS eu1.ethermine.org:4444 -S us1.ethermine.org:4444 -O f68Ee5E57BaA048b03C3b71Bb0123381fec4dC4F
echo "showing sessions:"
echo (tmux list-sessions)
