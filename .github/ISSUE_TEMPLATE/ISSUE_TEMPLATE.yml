name: 🐞 Bug
description: File a bug/issue
title: "[BUG] <title>"
labels: [Bug, Needs Triage]
body:
- type: checkboxes
  attributes:
    label: Is there an existing issue for this?
    description: Please search to see if an issue already exists for the bug you encountered.
    options:
    - label: I have searched the existing issues
      required: true
- type: textarea
  attributes:
    label: Description
    description: A concise description of what you're experiencing.
  validations:
    required: false
- type: textarea
  attributes:
    label: Expected Behavior
    description: A concise description of what you expected to happen.
  validations:
    required: false
- type: textarea
  attributes:
    label: Steps To Reproduce
    description: Steps to reproduce the behavior.
    placeholder: |
      1. I executed this command:
      ```shell
      # your command here
      ```
      Output:
      ```
      # output of your command
      ```
  render: markdown
  validations:
    required: false
- type: textarea
  attributes:
    label: Environment
    description: |
      Paste the output of `crew sysinfo -v` between two `***` below
    value: |
        ***
        ***
    render: markdown
  validations:
    required: false
- type: textarea
  attributes:
    label: Anything else?
    description: |
      Links? References? Anything that will give us more context about the issue you are encountering!
      What I think needs to be done:
      - [ ] step one
      - [ ] step two
      Tip: You can attach images or log files by clicking this area to highlight it and then dragging files in.
  render: markdown
  validations:
    required: false
