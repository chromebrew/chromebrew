require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version '3.8.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1986a539c536d47d42567f0fe8d9b6a5d6a12285c52ececc48a48c2920b46fc2',
     armv7l: '1986a539c536d47d42567f0fe8d9b6a5d6a12285c52ececc48a48c2920b46fc2',
       i686: '1549d7f0841219a06dcd5ae4c9d31424d5322e7bb79aef4ace3549dd325d9931',
     x86_64: '7fff6ebab0ea6cbc588677ccfc5b27f6237722ab02c9ed8180aa01aecdc83706'
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
