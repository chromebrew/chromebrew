require 'package'

class Libksba < Package
  description 'Libksba is a library to make the tasks of working with X.509 certificates, CMS data and related objects more easy.'
  homepage 'https://www.gnupg.org/related_software/libksba/index.html'
  version '1.3.5'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2'
  source_sha256 '41444fd7a6ff73a79ad9728f985e71c9ba8cd3e5e53358e70d5f066d35c1a340'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libksba-1.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libksba-1.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libksba-1.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libksba-1.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '898d4baff97186c7b0aabee91e60f74b074da7ed28bdf2670d390f34c42848f1',
     armv7l: '898d4baff97186c7b0aabee91e60f74b074da7ed28bdf2670d390f34c42848f1',
       i686: 'a252053a017753e427cdd776a3efd5f8789b1b9df38393456cc246b08e11e29b',
     x86_64: '8ea377d11ae5f553564ec2a9b1328d2a3d3d0de4324aa22214a1ecf357b5a5c8',
  })

  depends_on 'npth'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
