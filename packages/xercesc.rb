require 'buildsystems/autotools'

class Xercesc < Autotools
  description 'Xerces-C++ is a validating XML parser written in a portable subset of C++.'
  homepage 'https://xerces.apache.org/xerces-c/'
  version '3.3.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/apache/xerces-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08c39e12821035988630c10496a85173743089f88661352dff107458c8462121',
     armv7l: '08c39e12821035988630c10496a85173743089f88661352dff107458c8462121',
       i686: 'c1ffc9af8cd5af9e72e51d2015e2a3ab64b87334fc96a1ef962d489f3c803432',
     x86_64: '9e59c9d153c5d78fb15127ba1940fd12dba45835d696dd7d721aa5af0d6e5c74'
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
