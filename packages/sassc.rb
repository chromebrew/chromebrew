require 'buildsystems/autotools'

class Sassc < Autotools
  description 'C implementation of Sass CSS preprocessor.'
  homepage 'https://github.com/sass/sassc'
  version '3.6.2-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sass/sassc.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f651a9de4a61d1cf70395b20cc3ebe791bf2c22a6926334b614fb2ee9073e619',
     armv7l: 'f651a9de4a61d1cf70395b20cc3ebe791bf2c22a6926334b614fb2ee9073e619',
       i686: '538857ea1f1e5821b808f201e5d2fef2b58408b34557f9571fd84ae5800fb30a',
     x86_64: '269d6fd0a548986c1ced744ddfb9b94caf51c430697ddbaf32fa8bb844c19c1e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libsass' # R
end
