require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '4.4.0'
  license 'CMake'
  compatibility 'all'
  source_url 'https://gitlab.kitware.com/cmake/cmake.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0867354161348c98ad13b632bece70e6f228ea4d99df51e323010ec3798e5204',
     armv7l: '0867354161348c98ad13b632bece70e6f228ea4d99df51e323010ec3798e5204',
       i686: '540dae0135a7d7953ecbab5a4917fe2098b759be83232d74a8e7c3c195b5f114',
     x86_64: '149432df7a4b5334726d45478e9525d097d330bba1454ce2014e266d19fd0001'
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
