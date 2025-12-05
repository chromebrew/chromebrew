require 'buildsystems/pip'

class Py3_pyyaml < Pip
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  version "6.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fae496e696756951fd9e08b726c5272e3c8cf024243082ba02f6226ea920661a',
     armv7l: 'fae496e696756951fd9e08b726c5272e3c8cf024243082ba02f6226ea920661a',
       i686: 'f0b0c4e59e231d5271d8e27b31744c8e16adabd00c3ce7402c1cf5f668e1653a',
     x86_64: 'fe440c8306d9a350ab68edb395191ee74725673a31f7c493e0b62181ffc73132'
  })

  depends_on 'glibc' # R
  depends_on 'libyaml' # R
  depends_on 'python3' # R

  no_source_build
end
