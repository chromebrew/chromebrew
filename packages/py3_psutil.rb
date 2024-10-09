require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version "6.0.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a867985e6598c7b86790c5f9365092d306db1cbd41660f51cfed10906b820107',
     armv7l: 'a867985e6598c7b86790c5f9365092d306db1cbd41660f51cfed10906b820107',
       i686: 'af69c098f0048389adf8201b9df84b835389dc757e22b8b4be2d28a9418889c6',
     x86_64: '80fcbfc7bedad56b3fd55cac86da7b6e814ee5f3e59602aaaeb0ada1d3e30760'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
