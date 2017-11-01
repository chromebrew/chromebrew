require 'package'

class Npth < Package
  description 'nPth is a library to provide the GNU Pth API and thus a non-preemptive threads implementation.'
  homepage 'https://www.gnupg.org/related_software/npth/index.html'
  version '1.5'
  source_url 'https://www.gnupg.org/ftp/gcrypt/npth/npth-1.5.tar.bz2'
  source_sha256 '294a690c1f537b92ed829d867bee537e46be93fbd60b16c04630fbbfcd9db3c2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/npth-1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/npth-1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/npth-1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/npth-1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '85690b43e0dce9fb4f865224c14cec9ca9450c649a0c03adf05bdde875225ef9',
     armv7l: '85690b43e0dce9fb4f865224c14cec9ca9450c649a0c03adf05bdde875225ef9',
       i686: '15eae6c3d1a82bbc00bdd1fa505933ea6cfd7d5c55d216a5c469b07c706b1fd6',
     x86_64: '2e062b202c6e26e0a2bf3342599bc25872edf311ebf406326dc9fdd43d7daca2',
  })

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
