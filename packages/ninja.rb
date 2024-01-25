require 'buildsystems/cmake'

class Ninja < CMake
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  @_ver = '1.12.0'
  version "#{@_ver}-885b4ef"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja.git'
  git_hashtag '885b4efb41c039789b81f0dc0d67c1ed0faea17c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3703cfe35dc9e4a52c9fe1a2fafe1545ea840b6934deb7e2f86ae5fe27dbc51',
     armv7l: 'd3703cfe35dc9e4a52c9fe1a2fafe1545ea840b6934deb7e2f86ae5fe27dbc51',
       i686: '323e22fbc63bfb38ec28113469b1f24a5249d17ca5b8a02f9660738c05aca011',
     x86_64: '2dafb6d42eef4f788590c04f951a04d244e492a7e3d3867fc4ca959d8d4fd454'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 're2c' => :build

  def self.patch
    puts 'Patching to use /proc/loadavg'.orange
    downloader 'https://patch-diff.githubusercontent.com/raw/ninja-build/ninja/pull/2268.patch',
               'a1c1f218ac1625ac1ba371c1d40f788e902a9f8bbbcfa76627bd21fdf2f4b79b'
    system 'patch -p1 -i 2268.patch'
    puts 'Patching to update status on edge finish'.orange
    downloader 'https://patch-diff.githubusercontent.com/raw/ninja-build/ninja/pull/2312.patch',
               '09608df70838e8af1a4dab69f735da071699cb10af2336dfe22f92451edbe886'
    system 'patch -p1 -i 2312.patch'
  end
end
