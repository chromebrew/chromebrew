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
    aarch64: '573e26b98d1320e2aecdcf5b6dd1fd514e84b62835ba0fe8c1e93b194a60051d',
     armv7l: '573e26b98d1320e2aecdcf5b6dd1fd514e84b62835ba0fe8c1e93b194a60051d',
       i686: '725ceac2aeb0e8f82f691e143e1d625c2db3ac25fd1fc5892454e8e7c25033e6',
     x86_64: '3c7657d71d6f7adfe70f3576789285ffda3edfac80a84d5e413eec3a949d3ab7'
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
