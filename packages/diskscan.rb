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

  depends_on 'glibc' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'termcap' => :library
  depends_on 'zlib' => :executable

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
