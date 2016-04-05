# Profile Patcher

Add `.profile.d` directory into `$HOME` or `/etc/skel` and require shell scripts
from it in `~/profile`. No more `~/.profile` patching! Just put all your scripts
into `~/.profile.d`.

Profile patcher can patch profile skeleton to make this work globally for each
user. Currently it supports `ubuntu` global skeleton patching only.

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
