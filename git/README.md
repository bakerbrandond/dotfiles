# Configuration Files

## File Descriptions

The [configuration files][1] are read in the following order:

1.  _`~/.gitconfig.key`_

### ~/.gitconfig.key

This file is sourced by all ~/.gitconfig, and thus, it should be kept as
small as possible and should only define your git name,
email and signing key information.

Create a the file ~/.gitconfig.key with contents appropriate substitutions.

#! ~/.gitconfig.key
	[user]
		name = Your Name
		email = yourname@yourdomain.XXX
		signingkey = DEADBEEFCAFE
