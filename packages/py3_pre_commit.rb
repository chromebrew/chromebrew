require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version '3.7.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3651fd8a932fa8d2d587070a8a46f7a59a27b76dd08a3f180f976bcc7cfe8f53',
     armv7l: '3651fd8a932fa8d2d587070a8a46f7a59a27b76dd08a3f180f976bcc7cfe8f53',
       i686: 'cbd4fee4a8941cc221f0148eb87561b52c19da296ab02d970f1e1166730bbc10',
     x86_64: '6b13ce2d264adcd5261c8a7f75ce84b7b9c24548379c42f3a18e9d0f7c10dfe2'
  })

  depends_on 'py3_cfgv'
  depends_on 'py3_identify'
  depends_on 'py3_nodeenv'
  depends_on 'py3_pyyaml' # L
  depends_on 'py3_virtualenv'
  depends_on 'python3'

  no_source_build

  def self.postinstall
    ExitMessage.add "\nTo complete the install, execute 'pre-commit install --install-hooks' in your local repository.\n".lightblue
  end
end
