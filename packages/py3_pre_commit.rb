require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.5.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c284ee176f61d1287ad3837ee2f968cd169d40bc2ba8a7dbc349ea918e8fd8bb',
     armv7l: 'c284ee176f61d1287ad3837ee2f968cd169d40bc2ba8a7dbc349ea918e8fd8bb',
       i686: '70c09fae08a861cb253fd5225c607b999815220f5ede6ed1b7744288c8ce6bf0',
     x86_64: 'b9c2db4ca1316a9ec339bbaf44d3788bafbc6861e90490c3769f1694652576ce'
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
