require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2afc04e17898bd940da71b783cec5a384366d13e9d91475d939eef85bcbcee34',
     armv7l: '2afc04e17898bd940da71b783cec5a384366d13e9d91475d939eef85bcbcee34',
       i686: 'dda171d1c8f16f26755270b4c28519bffb073e4614087ecffb73d875868a2fd8',
     x86_64: '2136c23109ea466db48091a6661c3e7524519ef972bb1330c7ffc4ce220f765e'
  })

  depends_on 'py3_cfgv'
  depends_on 'py3_identify' # L
  depends_on 'py3_nodeenv' # L
  depends_on 'py3_pyyaml' # L
  depends_on 'py3_virtualenv' # L
  depends_on 'python3' # R

  no_source_build

  def self.postinstall
    ExitMessage.add "\nTo complete the install, execute 'pre-commit install --install-hooks' in your local repository.\n".lightblue
  end
end
