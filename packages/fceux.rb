require 'buildsystems/cmake'

class Fceux < CMake
  description 'NES/FDS emulator with TAS support'
  homepage 'https://fceux.com/'
  version '2.7.0'
  compatibility 'aarch64 armv7l x86_64'
  license 'GPLv2'
  source_url 'https://github.com/TASEmulators/fceux.git'
  git_hashtag "fceux-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'ffmpeg'
  depends_on 'libarchive'
  depends_on 'libglvnd'
  depends_on 'sdl2_compat'
  depends_on 'libx11'
  depends_on 'libx264'
  depends_on 'libx265'
  depends_on 'libxkbcommon'
  depends_on 'minizip'
  depends_on 'qt5_base'
  depends_on 'qt5_declarative'
  depends_on 'qt5_tools'
  depends_on 'zlib'

  cmake_options '-DGLVND=1'

  def self.postinstall
    ExitMessage.add "Run \"fceux\" command (located in #{CREW_PREFIX}/fceux) to use.\n"
  end
end
