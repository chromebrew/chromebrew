all
rule 'MD003', style: :atx
rule 'MD029', style: :ordered

exclude_rule 'MD002' # We use HTML <h1> tag as the top level header
exclude_rule 'MD013' # Ignore 80 character line length limit.
exclude_rule 'MD022' # Ignore headers should be surrounded by blank lines
exclude_rule 'MD031' # Ignore code blocks should be surrounded by blank lines
exclude_rule 'MD032' # Ignore lists should be surrounded by blank lines
exclude_rule 'MD033' # We need HTML to center logo, which is not possible in pure Markdown
exclude_rule 'MD034' # Only until https://github.com/markdownlint/markdownlint/issues/191 is resolved
exclude_rule 'MD035' # Ignore horizontal rule style.
exclude_rule 'MD036' # Ignore emphasis used instead of a header.
exclude_rule 'MD041' # Ignore first line in file should be a top level header.
exclude_rule 'MD046' # Ignore code block style.
