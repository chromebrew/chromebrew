require 'buildsystems/meson'

class Jsoncpp < Meson
  description 'A C++ library for interacting with JSON.'
  homepage 'https://github.com/open-source-parsers/jsoncpp'
  version '1.9.8'
  license 'MIT, public-domain'
  compatibility 'all'
  source_url 'https://github.com/open-source-parsers/jsoncpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f1a5d254ed8141d46b606d0fd44470592cfacb6cc74ab106d3ea44ad97af0de',
     armv7l: '8f1a5d254ed8141d46b606d0fd44470592cfacb6cc74ab106d3ea44ad97af0de',
       i686: 'd12761c2fdf871ce29ce5d3bc6eada351f4cea573d4dc915bd341b167e713118',
     x86_64: 'ca9698f8d1b225eed7cb8f9c6371ac2f32943de90a9aef64fab8183e170d303f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
