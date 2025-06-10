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
    aarch64: 'ad03b735e0a60ab60b0c68cb5590b0f93206f31d50c27516b89c39814dcec6f1',
     armv7l: 'ad03b735e0a60ab60b0c68cb5590b0f93206f31d50c27516b89c39814dcec6f1',
       i686: '9ef95add0044d6d1681132eeb371c3214768af5caf9b25aaa8aa1fe7fa483ec4',
     x86_64: 'eab11fd7c7b070b0bdaaa130ef733168481a25c05ec7b4c285a3dd893f33e947'
  })

  depends_on 'glibc' # R
  depends_on 'libcap' => :build

  no_filefix
end
