require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd88ae37b7eae8333f575e5dade57452655ebebb129c553b14bfe9e2b6ca53cb5',
     armv7l: 'd88ae37b7eae8333f575e5dade57452655ebebb129c553b14bfe9e2b6ca53cb5',
       i686: '9234e6cae9c1ed816ded8964f4ca06d955bfe8b17fed5585f7ae431774942b6b',
     x86_64: '32da49332786b0c2ef0f9807aa9a26e42303c1e358e5803d2b4f27899cca1ac5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
