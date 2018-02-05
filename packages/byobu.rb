require 'package'

class Byobu < Package
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'http://byobu.org/'
  version '5.124'
  source_url 'https://launchpad.net/byobu/trunk/5.124/+download/byobu_5.124.orig.tar.gz'
  source_sha256 '4eca1287b95093ac4697e6ebf7312308d54af90630db151669c5f328e0bef122'

  binary_url ({
  })
  binary_sha256 ({
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
