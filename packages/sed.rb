require 'package'

class Sed < Package
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.5-1'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.5.tar.xz'
  source_sha256 '7aad73c8839c2bdadca9476f884d2953cdace9567ecd0d90f9959f229d146b40'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4bc8cd82d8a73e9bdd02b7d9d2425b590494715898c458660dc57a1506840d1c',
     armv7l: '4bc8cd82d8a73e9bdd02b7d9d2425b590494715898c458660dc57a1506840d1c',
       i686: '5510f48c86412589e772014562e1ef4ef209af5997d209e1dade9134376f4493',
     x86_64: 'dc73fea56d081f60f594eadc91808390ba997bb41de22f038cc022a7945cc117',
  })

  depends_on 'acl'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--without-selinux"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
