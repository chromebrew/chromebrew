require 'package'

class Libva_utils < Package
  description 'Libva-utils is a collection of tests for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.10.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/intel/libva-utils/releases/download/#{@_ver}/libva-utils-#{@_ver}.tar.bz2"
  source_sha256 '33f06929faa395f55ec816432679219c56d70850bf465c848f0418e8a4f0352b'

  depends_on 'libva'

  def self.build
    system "env CFLAGS='-pipe -fstack-protector-strong -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -fstack-protector-strong -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      LDFLAGS='-fstack-protector-strong -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
