require 'package'

class Help2man < Package
  description "help2man produces simple manual pages from the '--help' and '--version' output of other commands."
  homepage 'https://www.gnu.org/software/help2man/'
  version '1.47.4'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/help2man/help2man-1.47.4.tar.xz'
  source_sha256 'd4ecf697d13f14dd1a78c5995f06459bff706fd1ce593d1c02d81667c0207753'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/help2man-1.47.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/help2man-1.47.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/help2man-1.47.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/help2man-1.47.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cc7d19aaa9ecb015b68f54d1d58308bf8c280a2a0248d0b1b27b6e6ae282fb5d',
     armv7l: 'cc7d19aaa9ecb015b68f54d1d58308bf8c280a2a0248d0b1b27b6e6ae282fb5d',
       i686: '05026d7d242bb60cc357cbdb91bcf0cb701240ed748952cecb088a7b8902b89e',
     x86_64: '2b80d202e591f249ff3760a33d4e8457dd78cc260549d2fc7a24b84a37b7c168',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
