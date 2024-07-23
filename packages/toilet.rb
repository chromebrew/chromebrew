require 'buildsystems/autotools'

class Toilet < Autotools
  description 'The TOIlet project attempts to create a free replacement for the FIGlet utility.'
  homepage 'http://caca.zoy.org/wiki/toilet'
  version '0.3'
  license 'Copyright (C) 2004 Sam Hocevar'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'http://caca.zoy.org/raw-attachment/wiki/toilet/toilet-0.3.tar.gz'
  source_sha256 '89d4b530c394313cc3f3a4e07a7394fa82a6091f44df44dfcd0ebcb3300a81de'
  binary_compression 'tar.zst'

  depends_on 'libcaca'

  binary_sha256({
    aarch64: '64841d83db9fc7be7c3cb307ce3a7c7d2b866b6655f757e0501ddc4d469767e9',
     armv7l: '64841d83db9fc7be7c3cb307ce3a7c7d2b866b6655f757e0501ddc4d469767e9',
     x86_64: '3e97b06c757e82acd295926e74f813a3ba8de1282d119fc7cbbe25844454821a'
  })

  run_tests
end
