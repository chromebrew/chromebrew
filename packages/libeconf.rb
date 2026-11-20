require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '45c45d3e9e636167040005be2ec79d63094dc00be41fc68dd8e86b5316994e1f',
     armv7l: '45c45d3e9e636167040005be2ec79d63094dc00be41fc68dd8e86b5316994e1f',
       i686: '122a10a62b4f4c60a196ba793b80ca0fe586d0f8bacfe1a167f211332614e54c',
     x86_64: 'fd7dc43ef2a19ee21b712bbe69c49e05d588ba863d3b247c564d76354dd2cb4c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
