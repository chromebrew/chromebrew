## Package Tests

These are simple bash shell scripts that test package binaries, manpages, etc. to make sure they are working correctly and do not generate errors. A test filename has the same name as the package without any extension, should be executable and have at least one line to validate the test(s). It should be placed in a subdirectory with the first letter of the package name. The subdirectory is necessary due to the sheer volume of packages and helps to organize files for manageability. This is similar to the directory structure of the manifest filelists. Keep in mind package tests will fail if the package is not installed.

### Running Tests

```bash
$ crew check <name> [<name2> <name3> ...]
```
where &lt;name&gt; is the crew package.  If the package test exists, it will run last in the check sequence.

### Examples

coreutils:
```bash
#!/bin/bash
for b in $(crew files coreutils | grep /usr/local/bin); do $b --version; done
```
This test is in the `c` directory.

github_cli:
```bash
#!/bin/bash
man gh | cat
gh --version
```
This test is in the `g` directory.
