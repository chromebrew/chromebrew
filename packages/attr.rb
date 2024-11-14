require 'buildsystems/autotools'

class Attr < Autotools
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'https://savannah.nongnu.org/projects/attr'
  version '2.5.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/attr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '6730b3d290f8aaea61bbe814606910e2b24ec1fc1dc1f751a7820c4ba3915be5',
     armv7l: '6730b3d290f8aaea61bbe814606910e2b24ec1fc1dc1f751a7820c4ba3915be5',
       i686: '15f296a5eeb14d80ffb85b6f38c10112fa5aab3d3caaceb6f250d49da51bf8f7',
     x86_64: '97ebf045a15e003b21a35401d8f7b5c40f6282840fdc10bdcba2def3bbfbb714'
  })

  depends_on 'libcap' => :build

  no_zstd
end
