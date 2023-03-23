# utilsh

A collection of posix compliant, executable, ad-hoc utility scripts. See [libsh](/christian-elsee/libsh) for a collection of "stdlib" type function decs/defs.

- [Requirements](#requirements)
- [Usage](#usage)
  - [git-rebase-author](#git-rebase-author)
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

#### ## <a id="git-rebase-author"></a>[src/git-rebase-author.sh](src/git-rebase-author.sh)

Rebases git history in order to change commiting author/email; the driver is mostly the need to change contact email.

```sh
# print usage
$ src/git-rebase-author.sh -h
usage:git-rebase-author.sh <sha> <author> <name>
```
```sh
# print latest commit log
$ git log -n1 | grep -E '^(commit|Author)'
commit 01422e4485bd71b27ddc5af36a533c5aec2ddcec (HEAD -> feature/git-rebase-author.sh)
Author: christian <christian@elsee.xyz>
```
```sh
# update author
$ src/git-rebase-author.sh cc6b3edf7e7398aedfda87d5172c002bc42bc7fe~1 ssdd christian@elsee.xyz
Mar 23 03:47:40  christian[17850] <Debug>: Enter :: sha=cc6b3edf7e7398aedfda87d5172c002bc42bc7fe~1 name=ssdd email=christian@elsee.xyz
...
```
```sh
# print latest commit log again
$ git log -n1 | grep -E '^(commit|Author)'
commit cccae4b5fc39c97bd99dfb817f2855c9f2d4e906 (HEAD -> feature/git-rebase-author.sh)
Author: ssdd <christian@elsee.xyz>
```
#### ## <a id="mws"></a>[src/mws.sh](src/mws.sh)

- A socat-based minimal webserver,
- Returns a valid HTTP/1.0 response with an empty body
- Useful as a sanity check: an http clients' dispatch cycle and request payload

```sh
# usage
$ src/mws.sh -h
usage: mws.sh <port>

A minimal HTTP server
```
```sh
# bind to 8080
$ src/mws.sh 8080
Mar 23 13:46:31  christian[21054] <Debug>: Enter :: port=8080
2023/03/23 13:46:31 socat[21055] N listening on LEN=16 AF=2 0.0.0.0:8080
```
```sh
# curl from sep terminal/session/etc
$ curl -D/dev/stderr localhost:8080
HTTP/1.0 200 OK
```
```sh
# socat logs from request
2023/03/23 13:46:31 socat[21055] N listening on LEN=16 AF=2 0.0.0.0:8080
...
> 2023/03/23 13:48:16.001524  length=73 from=0 to=72
GET / HTTP/1.1
Host: localhost:8080
User-Agent: curl/7.64.1
Accept: */*
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
