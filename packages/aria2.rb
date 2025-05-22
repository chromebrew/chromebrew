require 'buildsystems/autotools'

class Aria2 < Autotools
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.37.0'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'all'
  source_url 'https://github.com/aria2/aria2.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cba450a3672a2ea35ad0a228dce99cec05085d07eceeeb2baf1d484cdd09aa26',
     armv7l: 'cba450a3672a2ea35ad0a228dce99cec05085d07eceeeb2baf1d484cdd09aa26',
       i686: '6f4f524477f9de173e47792750e909870dce186ca20039725b24ab800b10dc90',
     x86_64: '0cc12e9067364f391aa917979b7335f4edc2b3dd08bb0e648572430b23d25ac0'
  })

  depends_on 'brotli' # R
  depends_on 'c_ares' # R
  depends_on 'ca_certificates' # R
  depends_on 'cppunit' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'libgcrypt' # R
  depends_on 'libidn2' # R
  depends_on 'libssh2' # R
  depends_on 'libtasn1' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'nettle' # R
  depends_on 'openssl' # R
  depends_on 'p11kit' # R
  depends_on 'sqlite' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options "--with-libnettle --with-libgcrypt --with-libssh2 \
    --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"

  # run_tests
end
