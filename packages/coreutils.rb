require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'http://www.gnu.org/software/coreutils/coreutils.html'
  version '8.27'
  source_url 'https://ftpmirror.gnu.org/coreutils/coreutils-8.27.tar.xz'
  source_sha256 '8891d349ee87b9ff7870f52b6d9312a9db672d2439d289bc57084771ca21656b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '150a40838d94d5d53fd2b1596802147a2ec8e9cdb18c7771aa4b8b22bc3c7312',
     armv7l: '150a40838d94d5d53fd2b1596802147a2ec8e9cdb18c7771aa4b8b22bc3c7312',
       i686: 'cdfa9a67beecc2f9c8e62ed096af27c0a7f780e829786421d8a93d8c1e315cdc',
     x86_64: '5dee72c39c02c6039406f011394f499dcd91bcced4b62c4ea0fa155d12bab9b3',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
