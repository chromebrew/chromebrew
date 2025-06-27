require 'buildsystems/autotools'

class Sassc < Autotools
  description 'C implementation of Sass CSS preprocessor.'
  homepage 'https://github.com/sass/sassc'
  version '3.6.2-2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sass/sassc.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c875abe53efffbad34a9595d8451d3d0f9925018de5f3fc42fe676b0f540d9a5',
     armv7l: 'c875abe53efffbad34a9595d8451d3d0f9925018de5f3fc42fe676b0f540d9a5',
       i686: 'b294a022d0f07347486e6d42d0157d6d58fd3c7ff36556bc2b77e983fa623164',
     x86_64: '95c5d967a8934f182d6b972bbec0a6125897576b7962b9dac767deadc0481c9b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libsass' # R
end
