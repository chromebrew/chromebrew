require 'package'

class Libxi < Package
  description 'X.org libXi Client library for XInput'
  homepage 'https://x.org/wiki/'
  version '1.8.2'
  license 'MIT and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.x.org/archive/individual/lib/libXi-#{version}.tar.gz"
  source_sha256 '5542daec66febfeb6f51d57abfa915826efe2e3af57534f4105b82240ea3188d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'faed3d1ad11fa264c71cce0d762e3941f29dd1d00620f5a45fdcc27419f54be5',
     armv7l: 'faed3d1ad11fa264c71cce0d762e3941f29dd1d00620f5a45fdcc27419f54be5',
     x86_64: '24bdf3f93bc7ad40eb7af639c674eaa868987661abfa1c1e0f5602a4645e4653'
  })

  depends_on 'libx11'

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
