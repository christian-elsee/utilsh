# utilsh

A collection of posix compliant, ad-hoc utility scripts.

- [Requirements](#requirements)
- [Usage](#usage)
- [License](#license)

## Requirements

A list of soft dependencies available during the development of any given script

- git, 2.24.3
```sh
$ git --version
git version 2.24.3 (Apple Git-128)
```
- Bash, 5.1.8
```sh
$ bash --version
GNU bash, version 5.1.8(1)-release (x86_64-apple-darwin20.3.0)
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

## Usage

A list of the util scripts commited to this repo, which details usage and provides examples

#### git-rebase-author.sh

Rebases git history in order to change commiting author/email; the driver is mostly the need to change contact email.

Print usage.
```sh
$ src/git-rebase-author.sh -h
usage:git-rebase-author.sh <sha> <author> <name>
```

Print the latest commit log
```sh
$ git log -n1
commit 01422e4485bd71b27ddc5af36a533c5aec2ddcec (HEAD -> feature/git-rebase-author.sh)
Author: christian <christian@elsee.xyz>
Date:   Thu Mar 23 03:36:46 2023 +0100

    Use Get Opts Builtin To Display Usage
```

Update author
```sh
$ src/git-rebase-author.sh cc6b3edf7e7398aedfda87d5172c002bc42bc7fe~1 ssdd christian@elsee.xyz
Mar 23 03:47:40  christian[17850] <Debug>: Enter :: sha=cc6b3edf7e7398aedfda87d5172c002bc42bc7fe~1 name=ssdd email=christian@elsee.xyz
...
```

Print the latest commit log again
```sh
 $ git log -n1
commit cccae4b5fc39c97bd99dfb817f2855c9f2d4e906 (HEAD -> feature/git-rebase-author.sh)
Author: ssdd <christian@elsee.xyz>
Date:   Thu Mar 23 03:36:46 2023 +0100

    Use Get Opts Builtin To Display Usage
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
