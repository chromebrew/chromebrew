require 'buildsystems/cmake'

class Ninja < CMake
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.12.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9c7c3f0f22982ee2ac220e73e449c1458434525aff08afb910926c4d5d380cf',
     armv7l: 'b9c7c3f0f22982ee2ac220e73e449c1458434525aff08afb910926c4d5d380cf',
       i686: '20babb33e1e01ffd2ed2fa5125c2fced7b6b7820600a13bda7ec15b8f2ea8f51',
     x86_64: '46b369359e6277064e2c77fce5bcd4dc97df99bdcb2412c46f92cc8fb88f0e42'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 're2c' => :build

  cmake_options '-DBUILD_TESTING=OFF'

  def self.patch
    puts 'Patching to update status on edge finish.'.orange
    downloader 'https://patch-diff.githubusercontent.com/raw/ninja-build/ninja/pull/2312.patch',
               '09608df70838e8af1a4dab69f735da071699cb10af2336dfe22f92451edbe886'
    system 'patch -F 3 -p1 -i 2312.patch'
  end
end
