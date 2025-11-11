# Adapted from Arch Linux libfyaml PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libfyaml

require 'buildsystems/autotools'

class Libfyaml < Autotools
  description 'Fully feature complete YAML parser and emitter'
  homepage 'https://pantoniou.github.io/libfyaml'
  version '0.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pantoniou/libfyaml.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0a723ec9e431c1306cada7f697f5d14aacf0ced632cf854c022423959841268',
     armv7l: 'c0a723ec9e431c1306cada7f697f5d14aacf0ced632cf854c022423959841268',
       i686: '682868064b070a2329479341601e2457976cfa692414f2d1d5cc8c760816a9a3',
     x86_64: 'd1ed053fa4bacb5f022bc61cfe5d63bbd9b3250483fb0a76410623f533def077'
  })

  depends_on 'glibc' # R
  depends_on 'jq' => :build
end
