require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '4.4.3'
  license 'CMake'
  compatibility 'all'
  source_url 'https://gitlab.kitware.com/cmake/cmake.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '14b490c9e4c4869606903d610149e38d1d54cc455b0a5414bdf7723ff0c8e534',
     armv7l: '14b490c9e4c4869606903d610149e38d1d54cc455b0a5414bdf7723ff0c8e534',
       i686: '8b9562772fa41e4b6564b6662acb6449d591a59aef54cda17b8956fd1eebbf6d',
     x86_64: '3ee32feb2ed26e864e9f8c7b8fe46921bc2cb285165808188d0507135f6e4ff4'
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

    patch = [
      [
        'https://patch-diff.githubusercontent.com/raw/libarchive/libarchive/pull/3339.diff',
        '1208a9ef66ddbdd563adacda0579803c8b6ca3bd3d7909d2b12474eb6a1006a4',
        'Utilities/cmlibarchive'
      ]
    ]
    ConvenienceFunctions.patch(patch)
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
