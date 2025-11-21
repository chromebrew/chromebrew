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
    aarch64: '0bd19cc2cecf4f0c52658a876ed7975fabe3dcb455d5712f2084cfa24810e75d',
     armv7l: '0bd19cc2cecf4f0c52658a876ed7975fabe3dcb455d5712f2084cfa24810e75d',
       i686: 'ff3527ebd5ec3ef0330d896e60d425f5cc6ddb47d17fd6ce73fb04a3c26583e5',
     x86_64: 'bf085b08f4d0a8ebce3cf51ff4cbfae934d22c5b63152d484f325a793e436663'
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
