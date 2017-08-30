require 'package'

class Patch < Package
  description 'Patch takes a patch file containing a difference listing produced by the diff program and applies those differences to one or more original files, producing patched versions.'
  homepage 'http://savannah.gnu.org/projects/patch/'
  version '2.7.5'
  source_url 'https://ftp.gnu.org/gnu/patch/patch-2.7.5.tar.xz'
  source_sha256 'fd95153655d6b95567e623843a0e77b81612d502ecf78a489a4aed7867caa299'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/patch-2.7.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/patch-2.7.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/patch-2.7.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/patch-2.7.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '995d2690c10f31fcf48d6cc44004e506b572e4db182b334476d2473bfe1ac145',
     armv7l: '995d2690c10f31fcf48d6cc44004e506b572e4db182b334476d2473bfe1ac145',
       i686: '27bde4b24b9bae10efe371bd8569ecdf6f170ec042b2c16b8cc297131b5db48e',
     x86_64: 'd2b06c3df2ba789756703c55f6eab0fc347ba5e3c546d78c59223e6621b2fcd3',
  })

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
