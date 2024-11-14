require 'buildsystems/cmake'

class Ninja < CMake
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.12.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a6273179b9c9242db8c19708498d3de8a9bcc98292615cfbf44364cb4db4536',
     armv7l: '9a6273179b9c9242db8c19708498d3de8a9bcc98292615cfbf44364cb4db4536',
       i686: '98466d2c4986666d124e9cdac21a7e129ce86741a5823975410c0830cc49acf6',
     x86_64: '0216d7f30e7aeb8febfc94c7c985e109de83d3e836dc4c9d41164017113cc4b4'
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
