require 'buildsystems/pip'

class Py3_pre_commit < Pip
  description 'A framework for managing and maintaining multi-language pre-commit hooks.'
  homepage 'https://pre-commit.com/'
  version "4.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '283791effde6a63cef2c75f8a1fb9849c8159b34d5e3a1d8117965daa1fe9978',
     armv7l: '283791effde6a63cef2c75f8a1fb9849c8159b34d5e3a1d8117965daa1fe9978',
       i686: '1ec146614a09a5654890bf0f3d3294d6509c4b6e88d73eac3d267a2d3f6874f0',
     x86_64: '58822451084ad629e15fa122bb87be97f220c4a0c99521ed62b937d84d4947d7'
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
