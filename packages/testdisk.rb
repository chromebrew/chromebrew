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
    aarch64: '4a473b2a7c7e0febf61f8c3eb5e41e128a32eb2617e8dc5e4bc762e6faaecfec',
     armv7l: '4a473b2a7c7e0febf61f8c3eb5e41e128a32eb2617e8dc5e4bc762e6faaecfec',
       i686: '79b894377180aed08594df337d97a11348b655bc45a495013f9b2a54149c832b',
     x86_64: 'de56063c9af8983b41aa01ee6acd20d33638d4ba819027c69f52848eec570760'
  })

  depends_on 'e2fsprogs'
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo'
  depends_on 'ncurses'
  depends_on 'ntfs_3g'
  depends_on 'zlib'
end
