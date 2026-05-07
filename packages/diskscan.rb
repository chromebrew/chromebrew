require 'buildsystems/cmake'

class Diskscan < CMake
  description 'diskscan is intended to find sectors of a storage medium (hard disk, flash drive or pendrive, etc.) which are bad or in the process of going bad.'
  homepage 'http://blog.disksurvey.org/proj/diskscan/'
  version '0.21'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/baruch/diskscan.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a135d565fc00c1acd80a7c64b161bddf3670462d88a4eb757cdbc339a83b95ba',
     armv7l: 'a135d565fc00c1acd80a7c64b161bddf3670462d88a4eb757cdbc339a83b95ba',
       i686: '4fce0b84cbdc9ff7a1452e60f2a4b790475b41652871a575ab2134bb93a9584d',
     x86_64: 'eb91f270091e9e326f137ca3b3cb7cce1dfbfb9d061e99c14ba36781f63ac013'
  })

  depends_on 'glibc' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'termcap' => :library
  depends_on 'zlib' => :executable

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
