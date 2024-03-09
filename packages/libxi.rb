require 'package'

class Libxi < Package
  description 'X.org libXi Client library for XInput'
  homepage 'https://x.org'
  version '1.7.10'
  license 'MIT and custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://www.x.org/archive/individual/lib/libXi-#{version}.tar.gz"
  source_sha256 'b51e106c445a49409f3da877aa2f9129839001b24697d75a54e5c60507e9a5e3'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'faed3d1ad11fa264c71cce0d762e3941f29dd1d00620f5a45fdcc27419f54be5',
      armv7l: 'faed3d1ad11fa264c71cce0d762e3941f29dd1d00620f5a45fdcc27419f54be5',
      x86_64: '24bdf3f93bc7ad40eb7af639c674eaa868987661abfa1c1e0f5602a4645e4653'
  })

  depends_on 'libx11'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
