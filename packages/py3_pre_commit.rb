require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c76e8f3844cb95507876a3137c7d4feedcac9493da2da702e064df73ca6d0a1f',
     armv7l: 'c76e8f3844cb95507876a3137c7d4feedcac9493da2da702e064df73ca6d0a1f',
       i686: 'd26ab8a68c1356bbd912f26b85a2caee16402d8235b412c8da134def44f4269c',
     x86_64: '16ee36b0b0f37c79a1bcd256cd56a8045d96a1b17c57ec09776f3d86448788eb'
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
