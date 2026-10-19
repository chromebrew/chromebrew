require 'buildsystems/autotools'

class Haveged < Autotools
  description 'A simple entropy daemon based on the HAVEGE algorithm, significantly faster than /dev/urandom.'
  homepage 'https://issihosts.com/haveged/'
  version '1.9.27'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/jirka-h/haveged.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0ac5e0cc971a84df277de4ac07a8ea6e6cc560e787286861d1a2d0b0b15d731',
     armv7l: 'f0ac5e0cc971a84df277de4ac07a8ea6e6cc560e787286861d1a2d0b0b15d731',
       i686: '9d5bb3052b8735c56d4594d8360942b244dc334677809bc057134521676d7c52',
     x86_64: '38d39b670b9d1c6fe29ba78663f2eb8cdbb57bbea9d57dde01fc946833686821'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options ' \
    --disable-daemon \
    --enable-nistest \
    --enable-enttest \
    --enable-olt \
    --enable-threads'

  def self.prebuild
    system 'autoreconf -fiv'
  end

  run_tests
end
