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
    aarch64: 'c72de9f3173355193b1cff1019d86414fd154c051b4a10013a6bc01f496d8514',
     armv7l: 'c72de9f3173355193b1cff1019d86414fd154c051b4a10013a6bc01f496d8514',
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
