Tools needed: git, git-lfs, xattr, android-tools

First do:
git clone https://github.com/phhusson/ulefone-armor-9-gsi.git

Remember to:
"git lfs pull" to get the large files.

Then get the original system.img file you want to patch with the FLIR stuff.

To build the new s.img:
sudo bash generate.sh <original-system.img>

Now you can flash that file with:
fastboot flash system system.img


