require 'package'

class Pavuk < Package
  description 'Web spider and website mirroring tool.'
  homepage 'http://www.pavuk.org/'
  version '0.9.35'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/pavuk/files/pavuk/0.9.35/pavuk-0.9.35.tar.gz'
  source_sha256 'f9c64e511822c96a6714fa0bf336c1b0864767104c906e4393ab0fdf427815f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pavuk-0.9.35-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pavuk-0.9.35-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pavuk-0.9.35-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pavuk-0.9.35-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fce68e7d12bf1092079c51eb2fe6f47264506dc826eb86ea378c09b262ea47ae',
     armv7l: 'fce68e7d12bf1092079c51eb2fe6f47264506dc826eb86ea378c09b262ea47ae',
       i686: '5f18e15b2b73e9b1aee5eb3fbf001eb0841545ced689e72bdd5985050486dd78',
     x86_64: '9588693f44c76a06bd18534ab1c59259b1244298048ee0be8c1d87d60dead16b',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
