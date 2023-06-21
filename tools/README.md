### list of all tools

Tools to build pre-build binary easy.

- Makefile
- build.sh
- genpkgname.sh

Tools to upload and update URL in package files.

- chkfrog.sh
- upfrog.sh
- upload_github_release.sh

Tools to check URL or SHA stuff from packages files.

- create_sha_list.sh
- create_url_list.sh

Obsolete tools to create package.  Now, we use `crew build`.

- create_package.sh

### Usage of Makefile

Make working directory on your Chromebook and copy files there.
Then, performs `make` there.

```bash
mkdir /usr/local/work
cd /usr/local/work
cp your-path-for-original-tool-directory/{Makefile,build.sh,genpkgname.sh} .
make -k
```

### Usage of upfrog.sh

First, compile jfrog CLI from `https://www.jfrog.com/getcli/`.  Then, set it up.
After that, copy compiled pre-built binary to `release/$ARCH`.

```text
$ ./tools/upfrog.sh pango-1.40.9
[Info] Verifying repository chromebrew exists...
[Info] Verifying package pango exists...
[Info] Verifying version 1.40.9 exists...
[Info] Creating version...
[Info] Created version 1.40.9.
[Info] Collecting files for upload:. Done.
[Info] [Thread 2] Uploading artifact: release/x86_64/pango-1.40.9-chromeos-x86_64.tar.xz
[Info] [Thread 0] Uploading artifact: release/armv7l/pango-1.40.9-chromeos-armv7l.tar.xz
[Info] [Thread 1] Uploading artifact: release/i686/pango-1.40.9-chromeos-i686.tar.xz
[Info] Uploaded 3 artifacts.
[Info] Publishing version...
[Info] Published version 1.40.9, details:
{
  "files": 3
}
```

### Usage of chkfrog.sh

Copy compiled pre-built binary's SHA256 files to `release/$ARCH`.

```text
$ ./tools/chkfrog.sh pango
pango 1.40.9
https://dl.bintray.com/chromebrew/chromebrew/pango-1.40.9-chromeos-x86_64.tar.xz : c90a74dcba01ac1731aca5879b5b54dc9e1c49c3f61ec5f2861384db2bafa4eb
https://dl.bintray.com/chromebrew/chromebrew/pango-1.40.9-chromeos-i686.tar.xz : c24290af6d40c9fe1b9797942941e5a181533574188678b8f1f6f6a9ea319ba4
https://dl.bintray.com/chromebrew/chromebrew/pango-1.40.9-chromeos-armv7l.tar.xz : 60fb01a75558724abfbd879cef6877fca2ca17d802abeca7c487bb9d8b75a08c
```
