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
    aarch64: 'c73013a160bc0dfaff0811eeec432faa819a15186e10c8b5a5c98d043be256ca',
     armv7l: 'c73013a160bc0dfaff0811eeec432faa819a15186e10c8b5a5c98d043be256ca',
       i686: 'a27bb2d49527d80a37cf244ef4fd9dd673b62ccf06ddc313395a0d26f311ab77',
     x86_64: '28ccfec745895a9922e97afd43cc1ecdddbe980d47531b571808a1cab3fb0273'
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
