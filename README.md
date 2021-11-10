# windows-devenv

Run `main.bat` at repository root.

## custom SSH config file for VSCode `Remote - SSH` extension

Put custom SSH config file as `~/.ssh/config.d/vscode-remote-ssh` if necessary like below.

```sh
vagrant ssh-config --host vagrant > ~/.ssh/config.d/vscode-remote-ssh
```
