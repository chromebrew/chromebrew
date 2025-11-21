require 'buildsystems/cmake'

class Ninja < CMake
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.13.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f014da421a5b5066019ce9081efb4121350a10cec1cd27699ee0747c41cf736',
     armv7l: '2f014da421a5b5066019ce9081efb4121350a10cec1cd27699ee0747c41cf736',
       i686: '179858e70fbf8aa3383a1386937690af63b00b300488ec4f77b05d0416e31d2e',
     x86_64: '5eb66eb2cad0f11e61915d2c8e851076771e4fecef147079f1180dec070cddfa'
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
