require 'buildsystems/autotools'

class Whois < Autotools
  description 'Intelligent WHOIS client'
  homepage 'https://github.com/rfc1036/whois'
  version '5.6.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/rfc1036/whois.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '943ee1aa0e5450732694343accddf1a14c71fdcce060baaba84266bb861aa1a6',
     armv7l: '943ee1aa0e5450732694343accddf1a14c71fdcce060baaba84266bb861aa1a6',
       i686: '7e722134682492bdecd300d517ebdcfcb53e6a2665339857329ede1ca8dacf89',
     x86_64: 'ad3c41464a1ede24a1304261d66b79f46670a235086d766a20decdcd218e41d5'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'libxcrypt' => :executable

  autotools_skip_configure
  autotools_skip_autoreconf

  def self.patch
    system "sed -i 's,\$(BASEDIR)\$(prefix),#{CREW_DEST_PREFIX},g' Makefile"
    system "sed -i 's,\$(BASEDIR)\$(prefix),#{CREW_DEST_PREFIX},g' po/Makefile"
  end
end
