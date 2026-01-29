require 'buildsystems/autotools'

class Smallbasic < Autotools
  description 'SmallBASIC is a fast and easy to learn BASIC language interpreter'
  homepage 'https://smallbasic.github.io/'
  version '12.28'
  license 'GPLv3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/smallbasic/SmallBASIC.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f78c101263cce6a5e9acf170a58b857bf3cf458698a8c82100e8ab306f11bc7',
     armv7l: '9f78c101263cce6a5e9acf170a58b857bf3cf458698a8c82100e8ab306f11bc7',
     x86_64: '2de52d233212ee589d64d72d6bd103378cec2ae9a3e03915b46f353b5ab7f48d'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'msttcorefonts' # L
  depends_on 'pcre' # R
  depends_on 'sdl2' => :build
  depends_on 'sommelier' => :logical
  depends_on 'xxd_standalone' => :build

  autotools_configure_options '--enable-sdl'

  def self.postinstall
    puts "\nType 'sbasicg' to get started.\n".lightblue
  end
end
