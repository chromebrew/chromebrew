require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.27'
  source_url 'ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.27.tar.bz2'
  source_sha256 '4f93aac6fecb7da2b92871bb9ee33032be6a87b174f54abf8ddf0911a22d29d2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '53cbc0b9546361a96ec706c834a2db0f0545678e815f421c417e88c1192bdf7e',
     armv7l: '53cbc0b9546361a96ec706c834a2db0f0545678e815f421c417e88c1192bdf7e',
       i686: '002356d37f8c326f008fdc6eff7a67a944599a0855f38a5ad8c43f995a7a093d',
     x86_64: '31d69e7a2dd426cc16486f0e9b661e55fe7632fe1aa2bcabf3b083be0804a28a',
  })

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
