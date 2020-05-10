require 'package'

class Cscope < Package
  description 'Cscope is a developer\'s tool for browsing source code.'
  homepage 'http://cscope.sourceforge.net/'
  version '15.9'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/cscope/cscope/v15.9/cscope-15.9.tar.gz'
  source_sha256 'c5505ae075a871a9cd8d9801859b0ff1c09782075df281c72c23e72115d9f159'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cscope-15.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cscope-15.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cscope-15.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cscope-15.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0f80fc54e62abe731e07acd9be097c1b9b82eaa11662c17694549c2f6194c556',
     armv7l: '0f80fc54e62abe731e07acd9be097c1b9b82eaa11662c17694549c2f6194c556',
       i686: '54ee0731233d5d0b9f3fd15fdba8c3f80e6dd09a3db0cb47481ab8b07083a608',
     x86_64: 'cb071601673b5f2bd15ba5897b8ba2011cb22178f79ce91972d3bcbb9d9a7d77',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
