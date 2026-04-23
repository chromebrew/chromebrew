require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2288c6f0b2a5ceb013b39cf256b395b4a359ee4f02c11742d064873649a7d666',
     armv7l: '2288c6f0b2a5ceb013b39cf256b395b4a359ee4f02c11742d064873649a7d666',
       i686: '68feaf466de776afedc96a7df53ba21404e4e88ef5cbb552bf08887ccc32c413',
     x86_64: 'c637ca09da7737e0e75a92f72d5391cb84d73c9647d7fd13e628b295e23d90df'
  })

  depends_on 'py3_cfgv'
  depends_on 'py3_filelock' # Fixes ModuleNotFoundError: No module named 'filelock'
  depends_on 'py3_identify' => :logical
  depends_on 'py3_nodeenv' => :logical
  depends_on 'py3_pyyaml' => :logical
  depends_on 'py3_virtualenv' => :logical
  depends_on 'python3' => :logical

  no_source_build

  def self.postinstall
    ExitMessage.add "\nTo complete the install, execute 'pre-commit install --install-hooks' in your local repository.\n".lightblue
  end
end
