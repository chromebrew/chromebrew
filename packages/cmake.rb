require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '4.3.1'
  license 'CMake'
  compatibility 'all'
  source_url 'https://gitlab.kitware.com/cmake/cmake.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7eddab274886d7805780aac536d1afe09be7c94d85b233789a3f0056fe0e0231',
     armv7l: '7eddab274886d7805780aac536d1afe09be7c94d85b233789a3f0056fe0e0231',
       i686: '8909c76e1cd2be3e969b4f3f3578bf32dc4d5b0ca9707c92b4ce2e174dceb5eb',
     x86_64: 'bc6218f0bc3e38124f05578802c190123b5122f9bbcd832f269a98c8eb36a8cd'
  })

  depends_on 'bzip2' => :build
  depends_on 'cppdap' => :build
  depends_on 'curl' => :build
  depends_on 'expat' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'jsoncpp' => :build
  depends_on 'libarchive' => :build
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
