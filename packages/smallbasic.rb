require 'package'

class Smallbasic < Package
  description 'SmallBASIC is a fast and easy to learn BASIC language interpreter'
  homepage 'https://smallbasic.github.io/'
  version '12.23'
  license 'GPLv3'
  compatibility 'all'
  source_url 'https://github.com/smallbasic/SmallBASIC.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e86e6eda7034972b3d8cac560fab08c64eb9868105104b8846c8f0c5c4e5e8ec',
     armv7l: 'e86e6eda7034972b3d8cac560fab08c64eb9868105104b8846c8f0c5c4e5e8ec',
       i686: 'c3121b950dafdfb351db77cdedaebe15b7c0c7cccb9467c0df2770ca5c3beaac',
     x86_64: 'b4ab1ab31b5c350340245cded4e39ed3070dc65537c35640091ea721df0475c6'
  })

  depends_on 'libiconv'
  depends_on 'libsdl2'
  depends_on 'msttcorefonts'
  depends_on 'sommelier'

  def self.build
    system 'bash ./autogen.sh && filefix'
    system "./configure #{CREW_OPTIONS} --enable-sdl"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts "\nType 'sbasicg' to get started.\n".lightblue
  end
end
