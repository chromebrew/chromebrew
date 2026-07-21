# Adapted from Arch Linux faac PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/faac/trunk/PKGBUILD

require 'buildsystems/meson'

class Faac < Meson
  description 'Freeware Advanced Audio Coder'
  homepage 'https://www.audiocoding.com/'
  version '2.0'
  license 'GPL2 custom'
  compatibility 'all'
  source_url 'https://github.com/knik0/faac.git'
  git_hashtag "faac-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6249a7bbe2590c48ce8070823ca34d4ea03f315f38ef17d7e5b292ecefc05ac2',
     armv7l: '6249a7bbe2590c48ce8070823ca34d4ea03f315f38ef17d7e5b292ecefc05ac2',
       i686: '3332dc511f6ed2ce0737dce54ea0bdb023f29b714e8902a5c37d1bdb1bdeaf54',
     x86_64: '9f9a9dce35bd56d5794aed6496482cef46aacd8f5b0ce05124a29248e1940101'
  })

  depends_on 'glibc' => :library
end
