require 'buildsystems/autotools'

class Attr < Autotools
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'https://savannah.nongnu.org/projects/attr'
  version '2.5.2-4d4a562'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/attr.git'
  git_hashtag '4d4a562d7b73dcea8bd4b2d40b8c030d5065111b'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6730b3d290f8aaea61bbe814606910e2b24ec1fc1dc1f751a7820c4ba3915be5',
     armv7l: '6730b3d290f8aaea61bbe814606910e2b24ec1fc1dc1f751a7820c4ba3915be5',
       i686: '9ef95add0044d6d1681132eeb371c3214768af5caf9b25aaa8aa1fe7fa483ec4',
     x86_64: '97ebf045a15e003b21a35401d8f7b5c40f6282840fdc10bdcba2def3bbfbb714'
  })

  depends_on 'glibc' # R
  depends_on 'libcap' => :build
end
