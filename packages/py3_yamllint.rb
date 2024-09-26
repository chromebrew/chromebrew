require 'buildsystems/pip'

class Py3_yamllint < Pip
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  version "1.35.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7f9eb2ac5356a59d145c2fa17973fbe53a42765efff781ccadf74f76b14d293',
     armv7l: 'c7f9eb2ac5356a59d145c2fa17973fbe53a42765efff781ccadf74f76b14d293',
       i686: '776c715afda0728f29bd4be41fd53e6445a5c49cb1898fbc28341803817e4550',
     x86_64: 'ce279170064cd516c95f09fb145a56fba8390655b579fef0d0bd945b6f51290c'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
