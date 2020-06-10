require 'package'

class Libstrophe < Package
  description 'A simple, lightweight C library for writing XMPP clients'
  homepage 'http://strophe.im/libstrophe/'
  version '0.9.2'
  compatibility 'all'
  source_url 'https://github.com/strophe/libstrophe/archive/0.9.2.tar.gz'
  source_sha256 '158145bc1565a5fd0bbd7f57e3e15d768e58b8a460897ab5918a5a689d67ae6f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libstrophe-0.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libstrophe-0.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libstrophe-0.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libstrophe-0.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '35c2806eb3e47f25c7e249a601df8149112210344653f20e5eff4093a5dbbf95',
     armv7l: '35c2806eb3e47f25c7e249a601df8149112210344653f20e5eff4093a5dbbf95',
       i686: 'bea33dadf5dcd62377d20f51bb7189c2fb6c66c67cbddea3b78f435daf012833',
     x86_64: '8ef0cf5a6b74ca87b487577142918f0fff321613441e7c585a7460ea193e3abe',
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
