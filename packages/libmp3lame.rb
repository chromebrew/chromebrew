require 'package'

class Libmp3lame < Package
  description 'LAME is a high quality MPEG Audio Layer III (MP3) encoder licensed under the LGPL.'
  homepage 'http://lame.sourceforge.net/'
  version '3.99.5-1'
  source_url 'https://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz'
  source_sha256 '24346b4158e4af3bd9f2e194bb23eb473c75fb7377011523353196b19b9a23ff'

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
