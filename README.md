# homebrew-twoweeks

Homebrew tap for [`twoweeks`](https://github.com/Meliwat/twoweeks).

> Why your AI assistant always says two weeks but you ship by lunch.

## Install

```bash
brew install Meliwat/twoweeks/twoweeks
twoweeks "build the auth flow"
```

That's it. Runs on macOS and Linux. Requires Node (auto-installed via brew dependency) and Bun (used only at install time to build).

## Use

```bash
twoweeks "task"          # start a 2-week timer
twoweeks                 # status
twoweeks ship            # close it, print the brag card
twoweeks ship --share    # ship and open X with brag pre-filled
twoweeks history         # all shipped sessions + achievements + stats
twoweeks --help          # full command list
```

Full documentation at [github.com/Meliwat/twoweeks](https://github.com/Meliwat/twoweeks).

## License

MIT. The formula and the tool both.
