require 'package'

class Libsm < Package
  description 'X.org X Session Management Library'
  homepage 'http://www.x.org'
  version '1.2.4'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/archive/individual/lib/libSM-1.2.4.tar.gz'
  source_sha256 '51464ce1abce323d5b6707ceecf8468617106e1a8a98522f8342db06fd024c15'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsm/1.2.4_armv7l/libsm-1.2.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsm/1.2.4_armv7l/libsm-1.2.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsm/1.2.4_x86_64/libsm-1.2.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c8ac7992e45ada38ff88bbd3f72f824e028ba8ab2ee5b410b03ca6588a97e847',
     armv7l: 'c8ac7992e45ada38ff88bbd3f72f824e028ba8ab2ee5b410b03ca6588a97e847',
     x86_64: 'd58420a4d0a1cd459db032a5cee77848648483b9e00da0f6161edece6e3d2533'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libice' # R
  depends_on 'libmd' # R
  depends_on 'libx11' => :build
  depends_on 'util_linux' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
