require 'package'

class Libxxf86vm < Package
  description 'X.org the client library for the XFree86-VidMode X extension.'
  homepage 'https://www.x.org'
  version '1.1.5'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/archive//individual/lib/libXxf86vm-1.1.5.tar.xz'
  source_sha256 '247fef48b3e0e7e67129e41f1e789e8d006ba47dba1c0cdce684b9b703f888e7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b557e148bb31223dd3a97bab29ce8ccf666632e6e5fce6ce96226d666284493',
     armv7l: '1b557e148bb31223dd3a97bab29ce8ccf666632e6e5fce6ce96226d666284493',
       i686: '16a418e12139577cb3d56763c945b2ced2a950da49a2b65e495e307d292729e4',
     x86_64: 'fcfdd4e20c228aae10d7b671d6088a335b883bc07efec143db5d389fc080c5c9'
  })

  depends_on 'libxext'
  depends_on 'libx11'
  depends_on 'glibc' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
