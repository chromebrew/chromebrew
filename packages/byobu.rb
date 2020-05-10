require 'package'

class Byobu < Package
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'http://byobu.org/'
  version '5.125'
  compatibility 'all'
  source_url 'https://launchpad.net/byobu/trunk/5.125/+download/byobu_5.125.orig.tar.gz'
  source_sha256 '5022c82705a5d57f1d4e8dcb1819fd04628af2d4b4618b7d44fa27ebfcdda9db'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.125-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.125-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.125-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/byobu-5.125-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b24959d0ad54aed9655241f9492aa63473503c5720cfc66574b306e8a79edcb6',
     armv7l: 'b24959d0ad54aed9655241f9492aa63473503c5720cfc66574b306e8a79edcb6',
       i686: 'c3ca28d2979e3d7a0086b03be5508cf30ae115b60d22284803a06a8b7d3fcb0c',
     x86_64: 'f0a2933be3634409f9405e33979b06068f734d4a7b100dac01776a288fa3c843',
  })

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
