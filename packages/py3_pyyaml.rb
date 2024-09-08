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

  depends_on 'glibc' # R
  depends_on 'libyaml' # R
  depends_on 'python3' => :build
end
