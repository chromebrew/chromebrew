require 'package'

class Tcsh < Package
  description 'tcsh is a csh compatible shell with file name completion and command line editing.'
  homepage 'https://www.tcsh.org/'
  version '6.22.03'
  compatibility 'all'
  source_url 'https://astron.com/pub/tcsh/tcsh-6.22.03.tar.gz'
  source_sha256 'be2cfd653d2a0c7f506d2dd14c12324ba749bd484037be6df44a3973f52262b7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcsh-6.22.03-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcsh-6.22.03-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcsh-6.22.03-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcsh-6.22.03-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'caf87524b2701545318ba80f96c45c616ea2bbd98aab84bc7039c80142393943',
     armv7l: 'caf87524b2701545318ba80f96c45c616ea2bbd98aab84bc7039c80142393943',
       i686: '18d29203257ca85a42b31c4968207543efd38cbc89d12d0127bdc2bc7f30fcae',
     x86_64: 'a84996be2c9b34a339695bfdb04e51a5ad98aff123c95ad35e9fcca18ed0d54f',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
