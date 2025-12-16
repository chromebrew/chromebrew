require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3ff4f91ac187a06561eb22fc028ab6209a6fff795ae8ac4e222e2940b9c61f0',
     armv7l: 'b3ff4f91ac187a06561eb22fc028ab6209a6fff795ae8ac4e222e2940b9c61f0',
       i686: '4e57dba5497252d39440fe23bcb6ca34fe49162ca708cac982433d5e630150ff',
     x86_64: 'c891fd61d7345110e145b11cc0c710238cee716356acbdd124ebd58f34b8de42'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
