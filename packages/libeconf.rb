require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c1968fa15ddba8c15666e1ce75ed85234d76b0b35cb519aa851f9db12b83b4f',
     armv7l: '9c1968fa15ddba8c15666e1ce75ed85234d76b0b35cb519aa851f9db12b83b4f',
       i686: '290808e30d3580bd9c5bc7054b0a981a1976a091a31ff524de5808a834847c29',
     x86_64: 'b6a765daee3f28ff17b3444dbb464e0ef29781ef297d3f1d87119b0e549d1ef3'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
