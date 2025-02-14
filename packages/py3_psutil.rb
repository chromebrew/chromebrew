require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version "7.0.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69719f37fa5b10f863b15939e12daf735d5c900792a4d94a6d5dded17189bf5c',
     armv7l: '69719f37fa5b10f863b15939e12daf735d5c900792a4d94a6d5dded17189bf5c',
       i686: 'ebf1ed2b4b985425c7ce032ceb103f0a0ed9c15f71701d5c89e3f0dc808e93f3',
     x86_64: '8b2db25aabe2bea47856173382e551fc3ce1009161f0333534325a768b08f76d'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
