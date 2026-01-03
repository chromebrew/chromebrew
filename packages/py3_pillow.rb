require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "12.1.0-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50cf3eef76b7ce849940a973472f169e5854bcfe97f1bd751eb506f62a2b3267',
     armv7l: '50cf3eef76b7ce849940a973472f169e5854bcfe97f1bd751eb506f62a2b3267',
     x86_64: '2289c02cd714a0c9445eef49427a21c76e600251cd3b6f1236efd0afae5a1efe'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo'
  depends_on 'libxcb'
  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' # R
  depends_on 'zlib' # R

  no_source_build
end
