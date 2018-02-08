require 'package'

class Byobu < Package
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'http://byobu.org/'
  version '5.124'
  source_url 'https://launchpad.net/byobu/trunk/5.124/+download/byobu_5.124.orig.tar.gz'
  source_sha256 '4eca1287b95093ac4697e6ebf7312308d54af90630db151669c5f328e0bef122'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.124-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.124-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.124-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.124-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ae0a523b224701125020c8a8051a8993fc2999d29239ded9ad92935b4f71b79',
     armv7l: '6ae0a523b224701125020c8a8051a8993fc2999d29239ded9ad92935b4f71b79',
       i686: 'bc8d3e924a029ba6dece63a845c0a70d39afeab85ad0aab093f05ef49b6a45bd',
     x86_64: '633a6857112ea892bafa9718e7092161fdf161c7b75a5b3ad432cfb5f895506a',
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
