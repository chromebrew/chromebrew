require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b86f1c8fa2bfc4e217cd86fbacbbc7f927184ddad2c2c36c69c105e5dedeb6e8',
     armv7l: 'b86f1c8fa2bfc4e217cd86fbacbbc7f927184ddad2c2c36c69c105e5dedeb6e8',
       i686: '3db5b52e1ed9ba27e28224590042594da482aec85ec262edb76f606981768084',
     x86_64: 'c7981bda5523b664bca916d62b861b042a50650a5a4e3f019d40c1c80c51aca7'
  })

  depends_on 'python3' => :logical

  no_source_build
end
