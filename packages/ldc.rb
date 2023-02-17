require 'package'

class Ldc < Package
  description 'D language compiler using LLVM.'
  homepage 'https://github.com/ldc-developers/ldc'
  version '1.31.0'
  license 'BSD-3, Boost-1.0, MIT, NCSA and Artistic-1.0 or GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/ldc-developers/ldc.git'
  git_hashtag "v#{version}"

  depends_on 'dmd' => :build
  depends_on 'llvm' => :build

  def self.build
    #system "git clone -b v0.17.6 https://github.com/ldc-developers/ldc.git"
    #Dir.chdir 'ldc' do
    #  system 'git submodule update --init'
    #  Dir.mkdir 'build'
    #  Dir.chdir 'build' do
    #    system "cmake #{CREW_CMAKE_OPTIONS} .."
    #    system 'make'
    #  end
    #end
    #system './ldc/bin/ldmd2 --version'
    Dir.mkdir 'build'
    system "cmake #{CREW_CMAKE_OPTIONS} -G Ninja .. \
             -DD_COMPILER=#{CREW_PREFIX}/bin/dmd \
             -DBUILD_SHARED_LIBS=BOTH \
             -DCMAKE_SKIP_RPATH=ON \
             -DLDC_WITH_LLD=OFF \
             -Bbuild -H."
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
