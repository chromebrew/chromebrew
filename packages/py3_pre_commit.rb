require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79248f99e52f4b9d12b580b4d2ec1389920bd8e5bfe7d4e8deac7355df8d6a84',
     armv7l: '79248f99e52f4b9d12b580b4d2ec1389920bd8e5bfe7d4e8deac7355df8d6a84',
       i686: 'bdade6f75f60889d85691d5f76ffe0fd9b3e6361266197c1a3a6285603dd9120',
     x86_64: 'eb6d8cc70fd1d1bd8175e7d83d8d9c14eed253b632018db14b3d729518f95481'
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
