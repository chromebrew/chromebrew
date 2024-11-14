require 'buildsystems/autotools'

class Pinentry < Autotools
  description 'A collection of passphrase entry dialogs which is required for almost all usages of GnuPG'
  homepage 'https://gnupg.org/software/pinentry/index.html'
  version '1.3.1'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://gnupg.org/ftp/gcrypt/pinentry/pinentry-#{version}.tar.bz2"
  source_sha256 'bc72ee27c7239007ab1896c3c2fae53b076e2c9bd2483dc2769a16902bce8c04'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '536fc3599f6cffc1e7f8a89ec174dd4306e689e9e779ade0735a270ad6cd38b0',
     armv7l: '536fc3599f6cffc1e7f8a89ec174dd4306e689e9e779ade0735a270ad6cd38b0',
       i686: 'eabc731fb8cbabbd416b1714e28b511cb8fd9da86ead7f81fcb1e07b48cf86f4',
     x86_64: '8a07b26c69ccedb0b7092fbb5c91dce0a42d2679682be088a0a3095f764aa5b3'
  })

  depends_on 'glibc' # R
  depends_on 'libassuan' # R
  depends_on 'libcap' => :build
  depends_on 'libgpg_error' # R
  depends_on 'ncurses' # R
end
