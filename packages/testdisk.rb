require 'buildsystems/autotools'

class Testdisk < Autotools
  description 'TestDisk is powerful free data recovery software!'
  homepage 'https://www.cgsecurity.org/wiki/TestDisk'
  version '7.2'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/cgsecurity/testdisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: '79b894377180aed08594df337d97a11348b655bc45a495013f9b2a54149c832b',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'e2fsprogs'
  depends_on 'libjpeg_turbo'
  depends_on 'ncurses'
  depends_on 'ntfs_3g'
  depends_on 'zlib'
  depends_on 'glibc' # R
end
