require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.6.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '13760f3fab57aaad96f2a4f5d696eec8f118bd0d69754649a06159d8cc43d17d',
     armv7l: '13760f3fab57aaad96f2a4f5d696eec8f118bd0d69754649a06159d8cc43d17d',
       i686: 'fa2eccdfaad498e2ce27b8490eb405991de85486b70041a78ca71f2c70e24ce0',
     x86_64: 'f756125f721615ad464796288148fc045b417bb39561e0cf75317e1115c267e7'
  })

  depends_on 'py3_cfgv'
  depends_on 'py3_filelock' # Fixes ModuleNotFoundError: No module named 'filelock'
  depends_on 'py3_identify' => :logical
  depends_on 'py3_nodeenv' => :logical
  depends_on 'py3_pyyaml' => :logical
  depends_on 'py3_virtualenv' => :logical
  depends_on 'python3' => :logical
  depends_on 'shellcheck' => :executable

  no_source_build

  def self.postinstall
    ExitMessage.add "\nTo complete the install, execute 'pre-commit install --install-hooks' in your local repository.\n".lightblue
  end
end
