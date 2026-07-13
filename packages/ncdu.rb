require 'buildsystems/autotools'

class Ncdu < Autotools
  description 'Ncdu is a disk usage analyzer with an ncurses interface.'
  homepage 'https://dev.yorhel.nl/ncdu'
  version '2.9.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dev.yorhel.nl/download/ncdu-#{version}.tar.gz"
  source_sha256 'e91135281cb66569f2ca4c0bac277246991e7e52524c0ca8cba3de5c8e81cec9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0bdbf0c982ca1c38f96e4a39c419e52607be6f0beb44ce432321fb6573cd1f51',
     armv7l: '0bdbf0c982ca1c38f96e4a39c419e52607be6f0beb44ce432321fb6573cd1f51',
     x86_64: '5fe1748ad034063cecc32da6993f19a180879429f64bf4313a4a73570b0d5e34'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'llvm_dev' => :build
  depends_on 'ncurses' => :executable
  depends_on 'zig' => :build
  depends_on 'zstd' => :executable

  autotools_skip_configure
  autotools_install_options " \
    PREFIX=#{CREW_DEST_PREFIX} \
    CPPFLAGS='-I#{CREW_PREFIX}/include/ncurses'"
end
