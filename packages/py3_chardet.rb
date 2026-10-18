require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "7.7.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '247a2b4543becec7b0468ed9e6bbfc86207d09303c6b117ad6fedac7bceebfff',
     armv7l: '247a2b4543becec7b0468ed9e6bbfc86207d09303c6b117ad6fedac7bceebfff',
       i686: '7994b2300b2319b4a7fe0a60d44cb11ab322149fe7adb4ebe1f1d14245d51dd6',
     x86_64: '98115369e171cf6870fb05c8a576f5e9347366805c70b2b23eb68bb89d87b3de'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
