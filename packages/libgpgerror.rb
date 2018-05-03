require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.31'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.31.tar.bz2'
  source_sha256 '40d0a823c9329478063903192a1f82496083b277265904878f4bc09e0db7a4ef'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.31-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.31-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.31-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.31-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c19b538839f596514ba033075d943eb6994649407e9bbe96129bf9fd36c76d76',
     armv7l: 'c19b538839f596514ba033075d943eb6994649407e9bbe96129bf9fd36c76d76',
       i686: 'be2844cda5a0149693ace020f7b186bc68e4dc0924b0e3cc795744d33654f93e',
     x86_64: '207dab161f3d080e92b783c261a9d90b366961fd252bd49760bcb76e5af40085',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
