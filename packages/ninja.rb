require 'buildsystems/cmake'

class Ninja < CMake
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.13.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd86c68d1a9fe2aa7db45e788e67261e2eb9d32c1bf70d95aa9b874c5180bd77',
     armv7l: 'cd86c68d1a9fe2aa7db45e788e67261e2eb9d32c1bf70d95aa9b874c5180bd77',
       i686: 'd3b37e4bc424829e7729fbe4443810ae7cb681b81545c81a254a39d2310ffbe4',
     x86_64: '48c4285b8d85f09b65980b3d5d1641298220d48be6f5106fc9ebc174d5c5ae0d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 're2c' => :build

  cmake_options '-DBUILD_TESTING=OFF'

  cmake_build_extras do
    system "sed -i 's,/usr/bin/env ,#{CREW_PREFIX}/bin/,' misc/jobserver_pool.py"
  end

  cmake_install_extras do
    FileUtils.install 'misc/jobserver_pool.py', "#{CREW_DEST_PREFIX}/bin/jobserver_pool.py", mode: 0o755
  end
end
