require 'package'

class Libxi < Package
  description 'X.org libXi Client library for XInput'
  homepage 'https://x.org'
  @_ver = '1.7.10'
  version @_ver
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXi-#{@_ver}.tar.gz"
  source_sha256 'b51e106c445a49409f3da877aa2f9129839001b24697d75a54e5c60507e9a5e3'

  depends_on 'libx11'

  def self.build
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
