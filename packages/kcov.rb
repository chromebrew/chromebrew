require 'buildsystems/cmake'

class Kcov < CMake
  description 'Kcov is a code coverage tester for compiled programs, Python scripts and shell scripts.'
  homepage 'http://simonkagstrom.github.io/kcov/'
  version '43'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/SimonKagstrom/kcov.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '965e5c9d16fb3325ba725dd0f2d098ff378fac7517d2b84959d9b039c5953132',
     armv7l: '965e5c9d16fb3325ba725dd0f2d098ff378fac7517d2b84959d9b039c5953132',
       i686: '795b5571fcbaa96d52b20d0a1e650648d570740f7cbbcfd3a23aab3efc6b0161',
     x86_64: 'a5490ced1ddd6171f318d15cf02bf02fe8f2d8a85d6343ccd415c538c46ec7fb'
  })

  depends_on 'curl' => :executable
  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'py3_six' => :build
  depends_on 'zlib' => :executable

  def self.patch
    # Fix string sub-command REGEX, mode REPLACE needs at least 6 arguments total
    system "sed -i '46d' CMakeLists.txt"
    system "sed -i '42,44d' CMakeLists.txt"
    system "sed -i '39d' CMakeLists.txt"
    # Explicitly set the version.
    system "sed -i 's,set (PROJECT_VERSION,set (PROJECT_VERSION #{version}),' CMakeLists.txt"
  end
end
