require 'package'

class Rarian < Package
  description 'Documentation metadata library based on the proposed Freedesktop.org spec.'
  homepage 'https://rarian.freedesktop.org/'
  version '0.8.1'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/rarian/0.8/rarian-0.8.1.tar.bz2'
  source_sha256 'aafe886d46e467eb3414e91fa9e42955bd4b618c3e19c42c773026b205a84577'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rarian-0.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rarian-0.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rarian-0.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rarian-0.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0432d2e342be1d21b788bd906d12312faae65f9badef502c9cbcfe74c56aabf3',
     armv7l: '0432d2e342be1d21b788bd906d12312faae65f9badef502c9cbcfe74c56aabf3',
       i686: 'f8feef1bf91eb6fc6c503f8b088dcb23da53de683809d941e793fbeaaf87bb00',
     x86_64: '3ececd8ac3dce371c40d1b32c10b538821a2b74edff336d9c041f8fcab4ac09c',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
