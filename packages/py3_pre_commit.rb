require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '468013f1695e5a50453ec82c75006ccb724f651d5c2d3a530e24879fae554073',
     armv7l: '468013f1695e5a50453ec82c75006ccb724f651d5c2d3a530e24879fae554073',
       i686: '0f36161b9110d8caf0a5e6ef617266353cd7253a1d73cf03debc9d311c5bf731',
     x86_64: 'd91a6528ee1888d65cd16e67c12cf13e789cdec6bc47be8c4b9339cec4b50e92'
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
