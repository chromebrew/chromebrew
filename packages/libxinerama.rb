
require 'package'

class Libxinerama < Package
  description 'Xorg library'
  homepage 'https://www.x.org/'
  version '1.1.3'
  source_url 'https://www.x.org/archive//individual/lib/libXinerama-1.1.3.tar.gz'
  source_sha256 '0ba243222ae5aba4c6a3d7a394c32c8b69220a6872dbb00b7abae8753aca9a44'

  depends_on 'fontconfig'
  depends_on 'libxcb'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
