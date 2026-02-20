require 'buildsystems/autotools'

class Which < Autotools
  description 'which shows the full path of (shell) commands.'
  homepage 'https://carlowood.github.io/which/'
  version '2.23'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/which/which-#{version}.tar.gz"
  source_sha256 'b620507312c5e97566a3c6cfaf99144fefc18a0da7d941401dfa0f5f58fb0368'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '24d7a4bb63a3b5309963c325dcf8bb952e809f62247e0d99502b8ac4307e7432',
     armv7l: '24d7a4bb63a3b5309963c325dcf8bb952e809f62247e0d99502b8ac4307e7432',
       i686: '4ab67eac102748914780688d1b12a5dfa0d38b403f346b74148c16038a118420',
     x86_64: '97c4353ec10d5756a3ec4db272c388865b15964f32e94980560806cfc7208d1b'
  })

  depends_on 'glibc' => :executable_only
end
