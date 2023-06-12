require 'package'

class Gmmlib < Package
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  version '22.3.3'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/gmmlib.git'
  git_hashtag "intel-gmmlib-#{version}"

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gmmlib/22.3.3_x86_64/gmmlib-22.3.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '73746485904173970cd608975011f0c91628ebdd5c68d09fd615d27327da27da'
  })

  depends_on 'libva' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DRUN_TEST_SUITE=OFF \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
