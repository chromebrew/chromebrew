require 'package'

class Fly < Package
  description 'fly is a C program that creates PNG, JPEG or GIF images on the fly from CGI and other programs.'
  homepage 'http://www.w3perl.com/fly/'
  version '2.0.1'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url "http://www.w3perl.com/fly/dist/fly-#{version}.tar.gz"
  source_sha256 '492351681ee243fd90d2d386d813b9e2b5f8515c345e286d682cc2ea539ddcc6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ce67b8da73c06dbdbe767793fa7490ffb355d2390b46a3bdaeaeac89720f9d1',
     armv7l: '6ce67b8da73c06dbdbe767793fa7490ffb355d2390b46a3bdaeaeac89720f9d1',
     x86_64: '16263c36098f902401f56e54811b8ecce27ec16c3674bbc638b94924f185d97c'
  })

  depends_on 'freetype' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libgd' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libpng' => :executable
  depends_on 'zlib' => :executable

  def self.patch
    # Fix mold: error: fly.o:(.text): R_X86_64_32 relocation at offset 0x39e9
    # against symbol `<fragment>' can not be used; recompile with -fPIC
    system "sed -i 's,fly fly.o,fly fly.c,' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'fly', "#{CREW_DEST_PREFIX}/bin/fly", mode: 0o755
  end
end
