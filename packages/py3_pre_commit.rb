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
    aarch64: 'b5c203e07417ab2e9fd5662717186f6983465409c88106c26cda002e01c51068',
     armv7l: 'b5c203e07417ab2e9fd5662717186f6983465409c88106c26cda002e01c51068',
       i686: '19028091d46515ccad06d97f34a3bbac157f2399be6420bcff6961d01bfdbae1',
     x86_64: 'f101ff43ccee3d422701fa165c4b692321bd6eaee36144027d1a886480588a90'
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
