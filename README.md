
# esphome-config

ESPhome config for my ESP32 boards

# ESPEasy custom build

This is a quick start guide to using the ESPEasy custom build fork from [https://github.com/hansrune/esphome-config](https://github.com/hansrune/esphome-config)


## Prereqs

You will need:

- A `bash` shell environment or similar (Linux, MacOS, WSL does not really matter)
- python 3.8 or later

## Install tools

```bash
python -V                                                   # assess your python version 
mkdir -p ~/venv                                             # any top level dir for virtual environments will do
python3 -m venv ~/venv/esphome                              # set up a new python venv for esphome
source ~/venv/esphome/bin/activate                          # activate this environment
pip install pip --upgrade                                   # upgrade pip install first 
pip install esptool                                         # you may need esptool for uploads, resets etc of devices
pip install esphome                                         # this will take some time ...
sudo apt install tio                                        # optionally install tio or serial console IO from ESP devices
```

## Prepare code from git

```bash
cd && cd git                                                # go to where  you use your local git repositories
git clone https://github.com/hansrune/esphome-config.git    # either clone this repo for initial download
cd esphome-config/  
git pull                                                    # ... or update existing clone
git status                                                  # verify that you are on the expected branch
```

## Set up your local preferences

### Secrets

The secrets.yaml is kept outside the git repository. I prefer to set that up as follows:

```bash
touch ../secrets.yaml                                       # create secrets file outside of the repository
ln -s ../secrets.yaml .                                     # link that in here
grep '!secret' *.yaml */*.yaml                              # list the secrets you want to define
```

... then edit `secrets.yaml` with your favourite editor

### Other configuration options

Other options you may want to change:

1. `common/communication.yaml` - you may want to use Home Assistane *api* over *mqtt*.
2. `common/time.yaml` - change *time_timezone* to your timezone

### Create your own ESPHome instances

Copy `test*.yaml` templates to more meaningful filenames for your ESPHome devices. Then change the *subtitutions* section at the top to your preferences

## Build and upload

You can build the firmware like this. Before the initial upload, you will want to connect your ESP device to a local serial port. Later uploads can be over the air (OTA)

```bash
esphome compile your_device.yaml
esphome upload your_device.yaml
```

## Connect to serial port

You should check that the code loads from using a serial console. For example

```bash
tio /dev/ttyACM0
```

(use Ctrl+t q to quit)