require 'buildsystems/autotools'

class Bind < Autotools
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/bind/'
  version '9.21.5'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c884e14dd54d6371f913ea29b2e71dd6dfc781484e758665b533218fb63c2dc7',
     armv7l: 'c884e14dd54d6371f913ea29b2e71dd6dfc781484e758665b533218fb63c2dc7',
       i686: 'f000d1ab8ab6116faa1d244a20f95fc68db4661ed31a3400b1d918147997383b',
     x86_64: 'b61fc6619e1896cd492fd329d79bb3cba3f5197322beaeabb5c07481cc607801'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'jemalloc' # R
  depends_on 'json_c' # R
  depends_on 'krb5' # R
  depends_on 'libcap' # R
  depends_on 'libedit' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libunistring' # R
  depends_on 'liburcu' # R
  depends_on 'libuv' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'py3_ply' => :build
  depends_on 'sphinx' => :build
  depends_on 'zlib' # R

  configure_options '--enable-fixed-rrset --enable-full-report --with-libidn2'
end
