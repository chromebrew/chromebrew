require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.6.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b198ae1182b5e876be452917ae6c3f2f00691ec5f03b77a426cda1075325c16',
     armv7l: '5b198ae1182b5e876be452917ae6c3f2f00691ec5f03b77a426cda1075325c16',
       i686: '0380b138dba66b402c58a979f3a9971673def059c47cf3b5cba9d655fb6632d6',
     x86_64: 'a37c279d7e191f6dfba9ab4637f547e89506de9cdb5aac3e78325a3b1861574d'
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
