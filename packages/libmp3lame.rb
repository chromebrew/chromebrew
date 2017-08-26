require 'package'

class Libmp3lame < Package
  description 'LAME is a high quality MPEG Audio Layer III (MP3) encoder licensed under the LGPL.'
  homepage 'http://lame.sourceforge.net/'
  version '3.99.5-1'
  source_url 'https://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz'
  source_sha256 '24346b4158e4af3bd9f2e194bb23eb473c75fb7377011523353196b19b9a23ff'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmp3lame-3.99.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmp3lame-3.99.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmp3lame-3.99.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmp3lame-3.99.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83920c0516d5accbadc70750df3422501d311d4db3e38d003128e436e90db024',
     armv7l: '83920c0516d5accbadc70750df3422501d311d4db3e38d003128e436e90db024',
       i686: 'f59ed891926986f089e707eda22e45e73100d2e132c8a24033e14b3babea378c',
     x86_64: 'c59ee3f889284effb2c38d993f6bd90c460081e7dbc1978185c215ed19c3a2b5',
  })

  def self.build
    case ARCH
    when 'i686'
      # gcc-4.x for i686 has problem, so forcing to use -msse here.
      # see https://mail-index.netbsd.org/pkgsrc-users/2015/04/18/msg021393.html
      # and https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56145 for details.
      system 'CFLAGS="-O3 -fomit-frame-pointer -ffast-math -maccumulate-outgoing-args -msse" ./configure'
    else
      system "./configure"
    end
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
