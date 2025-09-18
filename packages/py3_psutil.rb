require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version "7.1.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20782e906d466d0444931e2683036b802eedfef67eef0e387036cd5b089242e6',
     armv7l: '20782e906d466d0444931e2683036b802eedfef67eef0e387036cd5b089242e6',
       i686: '50f04c0b37447d36349368fd7d2271f3589ab83355fbe73ae056b52bcb575660',
     x86_64: '3d4fa3c75857d922f279faf8a082838c2220e1e6f44ba380ec495911a12c0991'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
