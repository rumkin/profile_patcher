# Profile Patcher

The last `~/profile` patch. It adds `.profile.d` directory into `$HOME`
and automatically requires shell scripts from it. No more `~/.profile` patching!
Just put all your scripts into `~/.profile.d`.

It can patch profile skeleton to make this work for all new users.
Currently it supports `ubuntu` skeleton patching only or `/etc/skel` directory.

## Usage

Patch skeleton:
```bash
./patch.sh
```

Patch user directory:
```bash
./patch.sh $HOME # Or other dir
```

Now you can add shell script into `.profile.d` to avoid headache with manual
`~/.profile` patching.

## Installation

Install and patch skeleton:

```bash
wget https://raw.githubusercontent.com/rumkin/profile_patcher/master/patch.sh | bash
```

Install and patch specified directory:
```bash
PATCH_DIR=$HOME wget https://raw.githubusercontent.com/rumkin/profile_patcher/master/patch.sh | bash
```

Manual installation and patching:
```bash
wget https://raw.githubusercontent.com/rumkin/profile_patcher/master/patch.sh
sudo ./patch.sh ~root # Patch root
./patch.sh $HOME # Patch home
./patch.sh # Patch skeleton
```
