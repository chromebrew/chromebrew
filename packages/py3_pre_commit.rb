require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e4a70c33daa7a861598d6a9d84202acb3f300cb2f153b6535177616aa249dc2',
     armv7l: '7e4a70c33daa7a861598d6a9d84202acb3f300cb2f153b6535177616aa249dc2',
       i686: '7bf6837f592c739457b6937124a573bda700a8a669f3459997914ef0e7fb54a8',
     x86_64: '7c2f7e68657b97a094a7c33b49f2aeab5fb9b334c08d926fa29fbd595f03f019'
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
