# Contributing

**Are you wondering how you can get started?** You can learn how from this *free* series
[How to Contribute to an Open Source Project on GitHub](https://egghead.io/courses/how-to-contribute-to-an-open-source-project-on-github).

## Prerequisites

1. A GitHub project in which you have access
2. A text editor or IDE (integrated development environment)
3. Basic knowledge of the command line in a terminal session
4. [`git`](https://git-scm.com/)
5. [`SSH key`](https://help.github.com/articles/connecting-to-github-with-ssh/)

## How to submit a Pull Request (aka PR)

1. Click the _**Fork**_ button in the top right to copy the repo to your own GitHub project.
2. Open a terminal and clone your forked project locally:
```bash
$ git clone git@github.com:your-project-name/chromebrew.git && cd chromebrew
```
3. Create a branch for your PR:
```bash
$ git checkout -b update-cool-package
```
4. Add, edit or delete the file(s) you would like to change and save.
5. Test your changes!  See steps 7 through 11 in the `How to test a pending PR from another contributor` section below.
6. Stage your changes:
```bash
$ git add -A
```
7. Review your changes:
```bash
$ git diff --staged
```
8. Correct your changes and repeat steps 4 through 7, if necessary.
9. Commit your changes:
```bash
$ git commit -m "Add some awesome change to cool package"
```
10. Push your changes:
```bash
$ git push origin update-cool-package
```
11. Visit your project page in the browser: `https://github.com/your-project-name/chromebrew`
12. Click the _**New pull request**_ button next to the _**Branch:**_ selector drop-down.
13. Select your branch name from the _**compare:**_ selector drop-down on the right.
14. Scroll down and review your changes.
15. Click the _**Create pull request**_ button.
16. Add a short description of your change.
17. Click the _**Create pull request**_ button.

## How to test a pending PR from another contributor

1. Open the PR of interest.
2. Next to the green _**Open**_ badge, you should see something similar to:
```
contributor-name wants to merge 1 commit into chromebrew:master from contributor-name:update-cool-package
```
3. On the far right, take note of _**contributor-name:update-cool-package**_.  This is the PR contributor along with the branch they want to merge.
4. Open a terminal, change to your cloned chromebrew directory and execute:
```bash
$ git remote add contributor-name git@github.com:contributor-name/chromebrew.git
```
5. Fetch their branches:
```bash
$ git fetch contributor-name
```
6. Checkout their branch:
```bash
$ git checkout update-cool-package
```
7. If the requested change is a package:
```bash
$ cp packages/cool_package.rb /usr/local/lib/crew/packages/
```
8. Test the new or updated package:
```bash
$ crew upgrade cool_package
```
9. Examine the files to see if everything installed as expected:
```bash
$ crew files cool_package
```
10. Run some tests on executables, if applicable:
```bash
$ cool_package --version
$ cool_package --help
$ cool_package --some-other-option
```
11. To see if this package is a dependency for another package, execute:
```bash
$ grep "depends_on 'cool_package'" packages/*.rb
```
and, just in case:
```bash
$ grep 'depends_on "cool_package"' packages/*.rb
```
If the package is a dependency for another package, test commands of the other package, if possible, to see if they were affected in any way.

12. Visit the PR and add a comment suggesting any changes or mark it RTBC if everything looks good.

## Learn more

- Visit the [wiki](https://github.com/chromebrew/chromebrew/wiki)

## Pre-commit hooks.

Chromebrew has pre-commit hooks to catch errors before they make it to CI.

To install them, run `pre-commit install` in the root of the repository.

You will first need to install the pre-commit tool, which can be done via `crew install py3_pre_commit` on ChromeOS.

## Anitya

Chromebrew predominantly uses the [Anitya project](https://release-monitoring.org/) for monitoring upstream releases in `tools/version.rb`.

While Anitya runs on Red Hat infrastructure and is primarily used by Fedora, it is a cross-distribution project which goes a long way towards deduplicating work and strengthening the ecosystem.

We benefit a huge amount from the work already done and the freely available API, so be mindful when making changes and ensure that everyone benefits.

With that said, here are the common scenarios where changes to Anitya are required:
- Anitya is missing a package Chromebrew provides
- Anitya's package has broken upstream version detection
- `tools/version.rb` is not finding the Anitya package for the Chromebrew package
- `tools/version.rb` is finding the wrong Anitya package for the Chromebrew package

### Anitya is missing a package Chromebrew provides

Add the package to Anitya. Make an account, log in, and click the [Add Project](https://release-monitoring.org/project/new) button at the top. Anitya has its own documentation on how to do this, and you should follow that.

This will benefit not just Chromebrew, but any distribution shipping that package that uses Anitya.

### Anitya's package has broken upstream version detection

Fix the version detection. There is a large `Edit` button visible on each package page when you are logged in. Click that, and fix the issue. Maybe the project has switched websites, or the old regex has broken. Once you've fixed the issue, test that the check works as intended, and the submit the new version check.

Again, this will benefit Chromebrew as well as everyone else using Anitya.

### `tools/version.rb` is not finding the Anitya package for the Chromebrew package

Add a distribution mapping to the project. Towards the bottom of each package page is a button titled `Add new distribution mapping`. Click on that, select Chromebrew, and enter the filename of the Chromebrew package in the package name field. For an example, you can look at [this mapping](https://release-monitoring.org/project/13824/), which is mapping the `mbedtls` Anitya package to the `libmbedtls` Chromebrew package.

### `tools/version.rb` is finding the wrong Anitya package for the Chromebrew package

This can happen for a number of reasons. `tools/version.rb` does its best to filter out incorrect packages by ecosystem and homepage, but this doesn't always succeed. Try and find the specific discrepancy between the Anitya and Chromebrew package that is causing them to not match, and fix it on the Chromebrew side. Anitya is used by many more people than just us, so we should change to match it, and not the other way around. If that isn't possible, you can add a hardcoded mapping to `CREW_ANITYA_PACKAGE_NAME_MAPPINGS` in `tools/version.rb` as a last resort.
