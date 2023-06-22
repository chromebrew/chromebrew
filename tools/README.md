### list of all tools

Tools to build pre-build binary easy.

- Makefile
- build.sh
- genpkgname.sh

Tools to upload and update URL in package files.

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
