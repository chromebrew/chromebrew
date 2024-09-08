require 'buildsystems/pip'

class Py3_pyyaml < Pip
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  version '6.0.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yaml/pyyaml.git'
  version '6.0.2-py3.12'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2215ad3e68ae779056258955c89d1a466e88312460ef608ea406d13b3e61780a',
     armv7l: '2215ad3e68ae779056258955c89d1a466e88312460ef608ea406d13b3e61780a',
       i686: 'ad0733204a5bb9fb168eb2164a0576a56d97cf7d5027a5226af404f49481fbcd',
     x86_64: '1565ef6f148ff8c7c5578dc81a76f551f12e4f3b8e53d1aec8d0e4eda4196ee7'
  })

  depends_on 'glibc' # R
  depends_on 'libyaml' # R
  depends_on 'python3' => :build
end
