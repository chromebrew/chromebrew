require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cef262e2d1795a42b8b6188a005ebd71347a2fdcd4c2b85607a3db0be6256124',
     armv7l: 'cef262e2d1795a42b8b6188a005ebd71347a2fdcd4c2b85607a3db0be6256124',
       i686: 'c3bbf7d27e4788c18cd5cd66d7b4c206835d9859ad9acd26446e65a84eb1dca3',
     x86_64: '898c6436c44b3ccb555fd43c0a598cc0b69937aab6accc44537fafce04b4a600'
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
