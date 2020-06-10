require 'package'

class Qemacs < Package
  description 'QEmacs (for Quick Emacs) is a very small but powerful UNIX editor.'
  homepage 'http://bellard.org/qemacs/'
  version '0.3.3'
  compatibility 'all'
  source_url 'http://bellard.org/qemacs/qemacs-0.3.3.tar.gz'
  source_sha256 '2ffba66a44783849282199acfcc08707debc7169394a8fd0902626222f27df94'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qemacs-0.3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qemacs-0.3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qemacs-0.3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qemacs-0.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b68631882ce0ff1edcaff8560e480813acf8e048ba0c897e554813fa9e01e72f',
     armv7l: 'b68631882ce0ff1edcaff8560e480813acf8e048ba0c897e554813fa9e01e72f',
       i686: '14dbc3246d8fe7a353d825af8ca56995c723fc14307f0b3bfce30392847a3569',
     x86_64: '8805f34fad650f1525e0013105f0f8ba3420df4cbfd0d9ef8d7b4e222cad68eb',
  })

  def self.build
    system "sed -i 's,css.h,libqhtml/css.h,' html2png.c"
    system "sed -i 's/$(prefix)/$(DESTDIR)$(prefix)/g' Makefile"
    system "./configure", \
           "--prefix=#{CREW_PREFIX}", \
           "--disable-x11", \
           "--disable-xv", \
           "--disable-xrender", \
           "--disable-html", \
           "--disable-png"
    system "make"
  end

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/bin"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/share/qe"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/man/man1"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
