# Contributing

**Are you wondering how you can get started?** You can learn how from this *free* series
[How to Contribute to an Open Source Project on GitHub](https://app.egghead.io/series/how-to-contribute-to-an-open-source-project-on-github).

## Prerequisites

1. A GitHub project in which you have access
2. Basic knowledge of the command line in a terminal session

## How to submit a Pull Request (aka PR)

1. Click the _**Fork**_ button in the top right to copy the repo to your own GitHub project.
2. Add, edit or delete the file(s) you would like to change and commit your changes through the GitHub web interface.
3. Test your changes!  See steps 4 through 10 in the `How to test a pending PR from another contributor` section below.
4. Correct your changes and repeat steps 4 through 7, if necessary.
5. Back to your project page in the browser: `https://github.com/your-username/chromebrew`
6. Click the _**New pull request**_ button next to the _**Branch:**_ selector drop-down.
7. Select your branch name from the _**compare:**_ selector drop-down on the right.
8. Scroll down and review your changes.
9. Click the _**Create pull request**_ button.
10. Add a short description of your change.
11. Click the _**Create pull request**_ button.

## How to test a pending PR from another contributor

1. Open the PR of interest.
2. Next to the green _**Open**_ badge, you should see something similar to:
```
contributor-name wants to merge 1 commit into chromebrew:master from contributor-name:update-cool-package
```
3. On the far right, take note of _**contributor-name:update-cool-package**_.  This is the PR contributor along with the branch they want to merge.

4. Open a terminal, execute the following to download their changes:
```bash
$ CREW_TESTING=1 CREW_TESTING_REPO=https://github.com/contributor-name/chromebrew CREW_TESTING_RERO=update-cool-package crew update
```

5. If the requested change is a package:
```bash
$ crew update compatible
```

6. Test the new or updated package:
```bash
$ crew upgrade cool_package
```

7. Examine the files to see if everything installed as expected:
```bash
$ crew files cool_package
```

8. Run some tests on executables, if applicable:
```bash
$ cool_package --version
$ cool_package --help
$ cool_package --some-other-option
```

9. To see if this package is a dependency for another package, execute:
```bash
$ grep "depends_on \('\|\"\)cool_package\('\|\"\)" packages/*.rb
```

If the package is a dependency for another package, test commands of the other package, if possible, to see if they were affected in any way.

10. Visit the PR and add a comment suggesting any changes or mark it RTBC if everything looks good.

## Learn more

- Visit the [wiki](https://github.com/chromebrew/chromebrew/wiki)
