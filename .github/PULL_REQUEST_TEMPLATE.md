Fixes #

<!-- (let GitHub automatically close an issue when this pull request gets merged) -->

<!--
## Before you submit a pull request

This template is not necessary when you do simple things like updating packages to the latest version. But in doubt, it's always better so provide some information.
-->

## Description
<!--
Provide a description, what your changes do and why they are important

Please link issues and other pull requests connected to this one.
-->

## Additional information
<!-- Mention things we might need to know. Like: -->

##
Builds:
- [ ] `x86_64`
- [ ] `i686`
- [ ] `armv7l`
##
Tested & Working properly:
- [ ] `x86_64`
- [ ] `i686`
- [ ] `armv7l` <!-- (reasons why it doesn't) -->
##
- [ ] This PR has no manifest .filelist changes. _(Package changes have neither added nor removed files.)_
##
### Run the following to get this pull request's changes locally for testing.
```bash
CREW_REPO=https://github.com/<Please_enter_the_name_of_your_repo>/chromebrew.git CREW_BRANCH=<Please_enter_the_branch_name_for_this_PR> crew update \
&& yes | crew upgrade
```

<!--
## That's it
Thank you for submitting your pull request.
When done, please delete the parts of this template which you don't need or these, which are only for guidance.
-->
