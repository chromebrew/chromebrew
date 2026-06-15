require 'buildsystems/autotools'

class Jp2a < Autotools
  description 'jp2a is a simple JPEG/PNG to ASCII converter.'
  homepage 'https://github.com/Talinx/jp2a'
  version '1.3.3'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Talinx/jp2a.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ee3d3bd47e418ec3631fd92f3b350b26704b10fe8853a3ff29f1e019932b0c1',
     armv7l: '9ee3d3bd47e418ec3631fd92f3b350b26704b10fe8853a3ff29f1e019932b0c1',
     x86_64: 'b7e1e269dbfd6a9c25e29790981f61c67f07ac7fd451275882f703b4e58b8a1c'
  })

  depends_on 'curl' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libexif' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libwebp' => :executable
  depends_on 'ncurses' => :executable

  autotools_pre_configure_options "CFLAGS='-lncurses -ltinfo -I#{CREW_PREFIX}/include/ncurses #{CREW_ENV_OPTIONS_HASH['CFLAGS']}' LDFLAGS='-L#{CREW_LIB_PREFIX} -lncurses -ltinfo #{CREW_ENV_OPTIONS_HASH['LDFLAGS']}'"
  autotools_configure_options '--enable-curl'

  def self.check
    system 'make check || true'
  end
end
