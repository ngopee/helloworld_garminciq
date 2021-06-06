# helloworld_garminciq


Credit: Following tutorial and learning from: https://medium.com/@JoshuaTheMiller/making-a-watchface-for-garmin-devices-8c3ce28cae08

Adjusting layout to fit Garmin Descent Mk2
Screen resolution: 280 x 280

Run Command:

# Launch the simulator:
connectiq

# Compile the executable:
monkeyc -d descentmk2 \
    -f monkey.jungle \
    -o hellowf.prg \
    -y <Path_to_dev_key>

# Run in the simulator
monkeydo hellowf.prg descentmk2
