require 'buildsystems/autotools'

class Xercesc < Autotools
  description 'Xerces-C++ is a validating XML parser written in a portable subset of C++.'
  homepage 'https://xerces.apache.org/xerces-c/'
  version '3.2.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/apache/xerces-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8b2b89232b64109e16cb378545adbc29d60a80ac141dc58ee303a83c5f5db4e',
     armv7l: 'f8b2b89232b64109e16cb378545adbc29d60a80ac141dc58ee303a83c5f5db4e',
       i686: '1573698c5fa1871953d6fe90bfa4cc613a71dde7bd1a63c36d83c184e5911ca5',
     x86_64: 'f1a1409f5fdcb3670d4f05c6fb500c554a871c073c478f51283de0d0ef993b8a'
  })

  depends_on 'brotli' # R
  depends_on 'c_ares' # R
  depends_on 'curl'
  depends_on 'e2fsprogs' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
  depends_on 'libtirpc' # R
  depends_on 'libunistring' # R
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options '--disable-static'
end
