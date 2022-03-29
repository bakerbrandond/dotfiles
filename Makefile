install:
	stow --verbose --target=$$HOME --restow --ignore=README.md */

uninstall:
	stow --verbose --target=$$HOME --delete --ignore=README.md */
