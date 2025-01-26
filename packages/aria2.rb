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
    aarch64: '2958e59e53018affc425e266259281492100376d3572876dae8261487a09c8bf',
     armv7l: '2958e59e53018affc425e266259281492100376d3572876dae8261487a09c8bf',
       i686: '8bc8d1defce3f5dae8ebb335023001b38ba024a76a6f4b3666ce68f499f4dcec',
     x86_64: 'd2740069111350977cede71df7e89189bbd701820d7dd627089dd25cc7927004'
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

  configure_options "--with-libnettle --with-libgcrypt --with-libssh2 \
    --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"

  # run_tests
end
