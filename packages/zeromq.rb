require 'buildsystems/autotools'

class Zeromq < Autotools
  description 'Fast messaging system built on sockets. C and C++ bindings. aka 0MQ, ZMQ.'
  homepage 'https://zeromq.org/'
  version '4.3.5'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/zeromq/libzmq.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c9dd94783114203775f59f38caf4166c00827c2b66b66b2e1812e4a595a6be3',
     armv7l: '0c9dd94783114203775f59f38caf4166c00827c2b66b66b2e1812e4a595a6be3',
       i686: 'c4c2847266ee5503a4ef92850d35ed3c7defa75070c7cd354ab90ca2efe60def',
     x86_64: 'e137a13cbbe23708483daaf1800dc789b792555e89213e87247b69490228e6f5'
  })

  depends_on 'libbsd'
  depends_on 'libmd' # R
  depends_on 'libunwind'

  # warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
  # compilation error: file /tmp/xmlto-xsl.bNfymk line 4 element import
  autotools_configure_options '--without-docs'
  run_tests
end
