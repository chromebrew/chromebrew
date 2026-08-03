require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '4.4.2'
  license 'CMake'
  compatibility 'all'
  source_url 'https://gitlab.kitware.com/cmake/cmake.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca14bc5c0472bee60e53668af268dde76f2c3e7d0c91b1471d1ed86881bb48d8',
     armv7l: 'ca14bc5c0472bee60e53668af268dde76f2c3e7d0c91b1471d1ed86881bb48d8',
       i686: 'd61f302051fd02301bc91064385c216aeec1ac4ed1607f6cb59118ebcd503302',
     x86_64: '9aa98fc06d413685e607b82d8198ea7a39321a8d38d5299e14e75340b134c4ab'
  })

  depends_on 'bzip2' => :build
  depends_on 'cppdap' => :build
  depends_on 'curl' => :build
  depends_on 'expat' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'jsoncpp' => :build
  depends_on 'libarchive' => :build
  depends_on 'libiconv' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'libnghttp2' => :build
  depends_on 'librhash' => :build
  depends_on 'libuv' => :build
  depends_on 'llvm_lib' => :build
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :executable
  depends_on 'xzutils' => :build
  depends_on 'zlib' => :build
  depends_on 'zstd' => :build

  def self.patch
    return unless version.include?('4.4')

    Dir.chdir('Utilities/cmlibarchive') do
      downloader 'https://patch-diff.githubusercontent.com/raw/libarchive/libarchive/pull/3339.diff', '1208a9ef66ddbdd563adacda0579803c8b6ca3bd3d7909d2b12474eb6a1006a4'
      system 'patch -Np1 -i 3339.diff'
    end
  end

  def self.build
    FileUtils.mkdir_p 'builddir'
    system '../bootstrap && make', chdir: 'builddir'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install", chdir: 'builddir'
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end

  # Failed tests:
  # BundleUtilities (armv7l,x86_64)
  # BootstrapTest (armv7l,i686,x86_64)
  # CMakeLib.testDebuggerNamedPipe-Project (armv7l,i686,x86_64)
  # CMakeLib.testDebuggerNamedPipe-Script (armv7l,i686,x86_64)
  # RunCMake.CMakeRelease (armv7l,i686,x86_64)
  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
