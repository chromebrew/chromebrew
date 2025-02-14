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
    aarch64: 'c1462ffa38457929fffad4512569062844872b589fa6b05fd9665632a583be52',
     armv7l: 'c1462ffa38457929fffad4512569062844872b589fa6b05fd9665632a583be52',
       i686: 'ebf1ed2b4b985425c7ce032ceb103f0a0ed9c15f71701d5c89e3f0dc808e93f3',
     x86_64: '126f8ce81336e732d0402cf5bc96ea9d875d750c01554d79707a9fca8c96225b'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
