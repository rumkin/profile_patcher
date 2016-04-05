# profile_patcher

Add `.profile.d` directory into `$HOME` and `/etc/skel`.

Currently supports only `ubuntu` global skeleton patching.

## Usage

Patch skeleton:
```bash
./patch.sh
```

Patch user directory:
```bash
./patch.sh $HOME # Or other user dir
```

Now you can add shell script into `.profile.d` to avoid headache with manual
~/.profile patching.
