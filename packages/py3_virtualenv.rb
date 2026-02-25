require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.39.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46234f5f1b6983220de13003f7471cd6ab45d3f5624e64c3fdd95ac24e094ce9',
     armv7l: '46234f5f1b6983220de13003f7471cd6ab45d3f5624e64c3fdd95ac24e094ce9',
       i686: 'fd72b4a109a5aaf1976b3f383ee84f6ec8f2ee52ff74ce57c7846edf9933df5c',
     x86_64: '42bc6467d072b38758992c8bb26fa92a222cc425f22257f4a4e448a80f740c6e'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
