require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe4f91c803bc8f5d11280c5c0876ceeb5b4a45d8fa80c4c0bfa4e7a7d892153e',
     armv7l: 'fe4f91c803bc8f5d11280c5c0876ceeb5b4a45d8fa80c4c0bfa4e7a7d892153e',
       i686: '8009f4c5fda51f962beb5f1307105c7b6cb73b077b9ecbcbfb05d974687d16fb',
     x86_64: '46f81a1f69d7a5c29a83625ef9168723e487b7f3c457ebd4918ea03a7d270ef3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
