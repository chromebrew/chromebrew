require 'package'

class Libnotify < Package
  description 'A library for sending desktop notifications.'
  homepage 'https://git.gnome.org/browse/libnotify'
  version '0.7.7'
  compatibility 'all'
  source_url 'https://github.com/GNOME/libnotify/archive/0.7.7.tar.gz'
  source_sha256 '8ff216938a47df591b454ad062465f6d91d7a83496a1ba8eb755df8952cf48f2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnotify-0.7.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnotify-0.7.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnotify-0.7.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnotify-0.7.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cdb253d6ded556e1ddf6c7a98b516861eadfdb73904455e6757349c5a79c815f',
     armv7l: 'cdb253d6ded556e1ddf6c7a98b516861eadfdb73904455e6757349c5a79c815f',
       i686: '583eed9e963a64f6ba1ca6fd65bf94c4c1b04fb63a763defc8a5c195b51fc253',
     x86_64: '1aac27b842844b8d171517261c043a28b1d1ae06b6fdef9c74e03767a21f77bd',
  })

  depends_on 'gtk_doc'
  depends_on 'gtk3'
  depends_on 'gnome_common'

  def self.build
    system "./autogen.sh"
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
