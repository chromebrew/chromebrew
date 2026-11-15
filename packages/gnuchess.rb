require 'buildsystems/autotools'

class Gnuchess < Autotools
  description 'GNU Chess is a chess-playing program.'
  homepage 'https://www.gnu.org/software/chess/'
  version '6.3.0'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/chess/gnuchess-#{version}.tar.gz"
  source_sha256 '0b37bec2098c2ad695b7443e5d7944dc6dc8284f8d01fcc30bdb94dd033ca23a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b17beb39478c400e526d94c1c7e81dd67815f357c0059aa4cfe23217e192688',
     armv7l: '3b17beb39478c400e526d94c1c7e81dd67815f357c0059aa4cfe23217e192688',
       i686: 'b96a487b59a6209e94e2a5e607c1c029eb12083694daf51f062ecaefce1a899f',
     x86_64: 'b55618a47776e38a8660fd6eaeec8beadbe043b4c3fafeef1bebba5bec752a3c'
  })

  depends_on 'gcc16_build' => :build
  depends_on 'gcc16_lib' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'readline' => :executable

  autotools_pre_configure_options "CXXFLAGS='-lpthread'"
  autotools_configure_options '--with-readline'

  run_tests
end
