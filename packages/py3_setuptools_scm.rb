require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "9.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5ed98bb5e2420dcdc683ae119785bf28266ca4b5f785f75686ce0753b109d99',
     armv7l: 'f5ed98bb5e2420dcdc683ae119785bf28266ca4b5f785f75686ce0753b109d99',
       i686: '4a938dbee7838bb4d431a7904ae92b3f35d710ad449f6757ad72b3f2e6f4be6d',
     x86_64: '4f5e0a7bfbc2578c0aee24272af2d068a9ac3778fcb85e654c197261a7d5ab6b'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  no_source_build
end
