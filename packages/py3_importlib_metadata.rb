require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "8.7.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb3c7553ef6b00338083dadb4ff4fdcc8b97fdb2c196b832657c0bf7efaa3b3b',
     armv7l: 'cb3c7553ef6b00338083dadb4ff4fdcc8b97fdb2c196b832657c0bf7efaa3b3b',
       i686: '3f79d3e7bef227b2cca5675af72df2a63c7281af007325f5929f67c4bc2a7bda',
     x86_64: 'a38cdcd9f393926bd98d098d1b52a806465973d2530c77d6b9b1e2f8037be696'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :build

  no_source_build
end
