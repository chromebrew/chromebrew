require 'buildsystems/cmake'

class Di < CMake
  description 'DI is a disk information utility, displaying everything (and more) that your \'df\' command does.'
  homepage 'https://diskinfo-di.sourceforge.io/'
  version '6.2.2.2'
  license 'ZLIB'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/diskinfo-di/di-#{version}.tar.gz"
  source_sha256 '19eeeb7ebcad3061ae7814cdae5593accfb2bb261ce24795a604a282cbfc60fe'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9652e3807cd9da2ec73a1c66b72f24da7b7fc8f9056d2b9c3de33b4e890ab417',
     armv7l: '9652e3807cd9da2ec73a1c66b72f24da7b7fc8f9056d2b9c3de33b4e890ab417',
       i686: '395ae0a7f3c58ad4a6e2520d17bfc11a6e5695ef55fca5e2ed59082387984c64',
     x86_64: 'ca094336b13d7fb906ba9ac61a000659d680d3e97dc14506e45506ab883243d8'
  })

  depends_on 'glibc' => :library
  depends_on 'libtirpc' => :library
  depends_on 'libtommath' => :library
  depends_on 'mpdecimal' => :library
end
