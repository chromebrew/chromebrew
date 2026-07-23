require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e9c56de4e8d14b00583f167b3fcc8b5607aab24719381d7f89fd222b55838700',
     armv7l: 'e9c56de4e8d14b00583f167b3fcc8b5607aab24719381d7f89fd222b55838700',
       i686: 'c2e76629e660f95c5999fa4166a9337411d336ab4174b6f92a48e2c455499d44',
     x86_64: '4d79d844e42e4a22e83dd21cfcdb0493f10345355463a1d8bfcb8ece9b36138f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
