require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '236b774d3fa2a552ec9022b94e4da83557a64852426abf4846e41e7dd902de95',
     armv7l: '236b774d3fa2a552ec9022b94e4da83557a64852426abf4846e41e7dd902de95',
       i686: '6d1bf7b4e83804d75006131fdb97de9cd4fae7935d7792f8eda7b776e4de58e4',
     x86_64: '25fc302486cd806d569b06349c4fdd56e381c94ba44a0a1d206cb5d3b3e997ea'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
