require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.0.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '007801da885fbd7aa7779459a643eb221fb1d13234b5c3791b487e7d1647bd72',
     armv7l: '007801da885fbd7aa7779459a643eb221fb1d13234b5c3791b487e7d1647bd72',
       i686: '0797df51ce7073f59e78dc43862cb42a3795f023f3c8fa1989561f61367a17f9',
     x86_64: '3a192dc3cdabc598bbf18f14547095f1ac7f3db4162f18c1e0ce071b15d00e58'
  })

  depends_on 'python3' => :logical

  no_source_build
end
