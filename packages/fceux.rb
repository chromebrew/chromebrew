require 'buildsystems/cmake'

class Fceux < CMake
  description 'NES/FDS emulator with TAS support'
  homepage 'https://fceux.com/'
  version '2.8.0'
  compatibility 'aarch64 armv7l x86_64'
  license 'GPLv2'
  source_url 'https://github.com/TASEmulators/fceux.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bff1deffd824161858340d3eb172cf1967e08961677f5e82d7c3aff2b9e552b8',
     armv7l: 'bff1deffd824161858340d3eb172cf1967e08961677f5e82d7c3aff2b9e552b8',
     x86_64: 'e45951aea4b41f8e825698f05422906710115d64aa130ac9ece17fd104ebfa88'
  })

  depends_on 'ffmpeg' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libarchive' => :executable
  depends_on 'libglu' => :executable
  depends_on 'libglvnd' => :executable
  depends_on 'libx11'
  depends_on 'libx264' => :executable
  depends_on 'libx265' => :executable
  depends_on 'libxkbcommon'
  depends_on 'minizip' => :executable
  depends_on 'qt5_base' => :executable
  depends_on 'qt5_declarative' => :executable
  depends_on 'qt5_tools' => :executable
  depends_on 'sdl2' => :executable
  depends_on 'sdl2_compat' => :executable
  depends_on 'zlib' => :executable

  cmake_options '-DGLVND=1'

  def self.postinstall
    ExitMessage.add "Run \"fceux\" command (located in #{CREW_PREFIX}/fceux) to use.\n"
  end
end
