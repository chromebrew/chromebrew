require 'package'

class Uchardet < Package
  description 'uchardet is an encoding detector library, which takes a sequence of bytes in an unknown character encoding without any additional information, and attempts to determine the encoding of the text.'
  homepage 'https://www.freedesktop.org/wiki/Software/uchardet/'
  version '0.0.6'
  license 'MPL-1.1, GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/uchardet/releases/uchardet-0.0.6.tar.xz'
  source_sha256 '8351328cdfbcb2432e63938721dd781eb8c11ebc56e3a89d0f84576b96002c61'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '3e3e33899d7c3752750fc9b71a43fe46728a2cc9b129ef2a66141c4db61f32f3',
     armv7l: '3e3e33899d7c3752750fc9b71a43fe46728a2cc9b129ef2a66141c4db61f32f3',
       i686: 'd212dd9da6356ed8a8f85f0cb969e81266ff7dd0b3922fee0f5968d701f95362',
     x86_64: '75d94151c984a1b983e765fdfe33f767c84170c0b95724671665d4a8f80cb4be'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=Release && make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
