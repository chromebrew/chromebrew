require 'buildsystems/meson'

class Tllist < Meson
  description 'A typed linked list C header file only library'
  homepage 'https://codeberg.org/dnkl/tllist'
  version '1.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://codeberg.org/dnkl/tllist.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b787e5e636aff6cab361687942593134c0a37d3163eb8e8b095c98ad8a068fe0',
     armv7l: 'b787e5e636aff6cab361687942593134c0a37d3163eb8e8b095c98ad8a068fe0',
       i686: '31850a41aa98f2d11fdf9d13c4015ca7f2669d1cd0b67c6b1299c73d5b51ff43',
     x86_64: '81947aa707f9934b2eef6d9ed1be0ee1b75218c8479bdbc79b541a74f0feff40'
  })

  run_tests
end
