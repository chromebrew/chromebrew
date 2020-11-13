require 'package'

class Libfontenc < Package
  description 'Fontenc Library from X.org'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libfontenc-1.1.4.tar.bz2'
  source_sha256 '2cfcce810ddd48f2e5dc658d28c1808e86dcf303eaff16728b9aa3dbc0092079'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '435c3bc5faa5f9884f72b9d2e18ab9c5df8c20d4fbcde9f0fe56044f46c8282c',
     armv7l: '435c3bc5faa5f9884f72b9d2e18ab9c5df8c20d4fbcde9f0fe56044f46c8282c',
       i686: '8ec003098172eac92ac155ef84e6486df46f62a012dee51fc548ff4358559f73',
     x86_64: '60dd2330462bd37bc69ba4ecafc2a0410e6eeeeffce41f6733f8b9ff7bf1d0b5',
  })

  depends_on 'xorg_proto'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts/X11"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
