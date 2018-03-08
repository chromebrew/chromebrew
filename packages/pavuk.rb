require 'package'

class Pavuk < Package
  description 'Web spider and website mirroring tool. http://www.pavuk.org/'
  homepage 'https://sourceforge.net/projects/pavuk/files/pavuk/'
  version '0.9.35'
  source_url 'https://sourceforge.net/projects/pavuk/files/pavuk/0.9.35/pavuk-0.9.35.tar.gz'
  source_sha256 'f9c64e511822c96a6714fa0bf336c1b0864767104c906e4393ab0fdf427815f6'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
