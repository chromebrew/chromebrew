require 'package'

class Byobu < Package
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'http://byobu.org/'
  version '5.123'
  source_url 'https://launchpad.net/byobu/trunk/5.123/+download/byobu_5.123.orig.tar.gz'
  source_sha256 '2e5a5425368d2f74c0b8649ce88fc653420c248f6c7945b4b718f382adc5a67d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.123-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.123-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.123-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.123-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '073f1c79f968e627dc05bd29a63e1f529c93e77272a3da897f2767324d03d186',
     armv7l: '073f1c79f968e627dc05bd29a63e1f529c93e77272a3da897f2767324d03d186',
       i686: '302bd45bd27dd5e6a51e1b94fa49a730b6dc677023d7c1dfc5c058d4ffaeff1e',
     x86_64: '796c3a38bc76c84cc284aeaae3a643c4f718551533eb7a0972d2b23bc7e65d0d',
  })

  depends_on 'gawk'
  depends_on 'tmux' unless File.exists? "#{CREW_PREFIX}/bin/screen"

  def self.build
    system './configure'
    system "sed -i '249d' Makefile && sed -i '262d' Makefile"
    system "sed -i '242iprefix = #{CREW_PREFIX}' Makefile"
    system "sed -i '243iexec_prefix = \${prefix}' Makefile"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
