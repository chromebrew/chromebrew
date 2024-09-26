require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "3.8.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3b919ae26f05e1219e6ce4a8d4c1c07ffcf4ed26b367c7dddff993782f9dcd1',
     armv7l: 'd3b919ae26f05e1219e6ce4a8d4c1c07ffcf4ed26b367c7dddff993782f9dcd1',
       i686: '95b5aed355837f26c46bb9770780f7a34c693ff6ac593da89c0f4bc4e0466df4',
     x86_64: 'de2247dec9286a780c8b87bbca1e12a3cf4950d5ff9cb1177df16b3acc0fcc17'
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
