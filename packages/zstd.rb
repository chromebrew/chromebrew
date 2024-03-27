require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.5.6' # Do not use @_ver here, it will break the installer.
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e0d0cccc416aa8a83c36ebe48ab6121ebca71803e587f2640bb35d726431e7d5',
     armv7l: 'e0d0cccc416aa8a83c36ebe48ab6121ebca71803e587f2640bb35d726431e7d5',
       i686: 'c886bd35878f11eca6db0cb00fdd9dbeb7b6b4e09d3d2a99b9c52df7218b2ddf',
     x86_64: '364c125580c760558ff0cd96989d9661159ed85a3bbdc9f2dde42e7a3bb9479b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  no_zstd

  def self.build
    Dir.chdir 'build/cmake' do
      system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
      -DZSTD_BUILD_STATIC=ON \
      -DZSTD_BUILD_SHARED=ON \
      -DZSTD_LEGACY_SUPPORT=ON \
      -DZSTD_BUILD_CONTRIB=ON \
      -DZSTD_PROGRAMS_LINK_SHARED=OFF \
      -G Ninja"
      system "#{CREW_NINJA} -C builddir"
    end
    system 'make -C tests'
  end

  def self.check
    system 'make -C tests check'
  end

  def self.install
    Dir.chdir 'build/cmake' do
      system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    end
    # Convert symlinks to hard links in libdir.
    Dir.chdir CREW_DEST_LIB_PREFIX do
      Dir['*'].each do |f|
        FileUtils.ln File.realpath(f), f, force: true if File.symlink?(f)
      end
    end
  end
end
