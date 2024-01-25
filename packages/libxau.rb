require 'package'

class Libxau < Package
  description 'xau library for libX11'
  homepage 'https://x.org'
  version '1.0.10'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXau-1.0.10.tar.xz'
  source_sha256 '8be6f292334d2f87e5b919c001e149a9fdc27005d6b3e053862ac6ebbf1a0c0a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a16d88d627e0762f6218f80794921dff3aa84f5b04d3cafe9d4bca32220aa11',
     armv7l: '3a16d88d627e0762f6218f80794921dff3aa84f5b04d3cafe9d4bca32220aa11',
       i686: 'e3507ff2731ec3413951cd04221aeef7811174c4c7aaa6094201b255423bb43d',
     x86_64: '4220fa07f5da76d1021d1cdbda1e12eefb8e3c27fc5f0f999d8de8396a38f3e1'
  })

  depends_on 'xorg_proto'
  depends_on 'glibc' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
