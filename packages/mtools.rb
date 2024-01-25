require 'package'

class Mtools < Package
  description 'Mtools is a collection of utilities to access MS-DOS disks from GNU and Unix without mounting them.'
  homepage 'https://www.gnu.org/software/mtools/'
  version '4.0.26'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/mtools/mtools-#{version}.tar.lz"
  source_sha256 'd09cff66d7277ad36a7573fc3e9803bfa558cdda83baabaafbf7761317462283'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'b04897069248682f60fe685c66cb74b1da86cbb393d80eca88a4445623a7f267',
      armv7l: 'b04897069248682f60fe685c66cb74b1da86cbb393d80eca88a4445623a7f267',
        i686: '35492c72f9e99631a58d3ad83847c9b6beca88bcda5549e5ca782fc404e7480d',
      x86_64: 'f844076f5ac3d63daf9e0468b13de4c9d17f0b479b46a2fed44d30f618c9fccb'
  })

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure --without-x #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
