require 'package'

class Libstrophe < Package
  description 'A simple, lightweight C library for writing XMPP clients'
  homepage 'http://strophe.im/libstrophe/'
  version '0.9.2'
  source_url 'https://github.com/strophe/libstrophe/archive/0.9.2.tar.gz'
  source_sha256 '158145bc1565a5fd0bbd7f57e3e15d768e58b8a460897ab5918a5a689d67ae6f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libxml2'

  def self.build
    system './bootstrap.sh'
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
