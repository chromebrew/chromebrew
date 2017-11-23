require 'package'

class Byobu < Package
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'http://byobu.org/'
  version '5.123'
  source_url 'https://launchpad.net/byobu/trunk/5.123/+download/byobu_5.123.orig.tar.gz'
  source_sha256 '2e5a5425368d2f74c0b8649ce88fc653420c248f6c7945b4b718f382adc5a67d'

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
