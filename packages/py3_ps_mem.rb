require 'buildsystems/pip'

class Py3_ps_mem < Pip
  description 'A utility to accurately report the core memory usage for a program'
  homepage 'http://github.com/pixelb/ps_mem'
  version "3.14-#{CREW_PY_VER}"
  license 'LGPLv2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55f2c8017ab0a93deb44c63626126db600a9e5cbe83603ce5f4cf312f240d035',
     armv7l: '55f2c8017ab0a93deb44c63626126db600a9e5cbe83603ce5f4cf312f240d035',
       i686: '2b7a74fc58e0b99c9c9463f48aa261e7d5d4924fe7d63772d837ad9a6eb47150',
     x86_64: '823faa9f7f50dd04f9a33d92edab8f4a027854ccf3827e59542d13633fbb3554'
  })

  depends_on 'python3' => :build

  no_source_build
end
