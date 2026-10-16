require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3392e31ba830fadd55b47fe3ab263516fde8e7149f5a894f308e1a04b1372cc2',
     armv7l: '3392e31ba830fadd55b47fe3ab263516fde8e7149f5a894f308e1a04b1372cc2',
       i686: '64ae67f97092fcd3ffbc36ef6ac8e7116a9fc9a5b70352a7cb2f06e5054ce09d',
     x86_64: 'cc8a09d69530c55dfd9614912e2ead8dd6243569c50980c82d3a8d8ea008369f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
