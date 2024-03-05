require 'buildsystems/meson'

class Mm_common < Meson
  description 'Common build files of the C++ bindings'
  homepage 'http://www.gtkmm.org/'
  version '1.0.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/mm-common.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a110f805f19bc44dbd355baed6cbb85291bfaafd6dd7a0e2e42c6abde4aa8d0e',
     armv7l: 'a110f805f19bc44dbd355baed6cbb85291bfaafd6dd7a0e2e42c6abde4aa8d0e',
       i686: '5d10a96b65a810fd6d3fb8d686307b15bea5dc54e7e30d5f3983ad0225493ca6',
     x86_64: '33eed58c4c387e25ee5d70a9b0c64525db105553918b03819a7ed27959c11553'
  })

  meson_options '-Duse-network=true'
end
