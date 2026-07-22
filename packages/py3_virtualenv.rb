require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c6635ea28ef29d0e228330c13d72665b24e0ed5565bd805b8e04630afb0e4b6',
     armv7l: '7c6635ea28ef29d0e228330c13d72665b24e0ed5565bd805b8e04630afb0e4b6',
       i686: 'ef9940e5fb91e4ff0fecfb58a1e09b1dcf69fc85770db049ab029a13028e9147',
     x86_64: '9331c42b38cf1ad84e4ea4e4453c27b5c1d9821d357b216990ad579f27632b95'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
