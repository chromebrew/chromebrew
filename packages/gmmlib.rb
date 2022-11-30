require 'package'

class Gmmlib < Package
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  @_ver = '22.3.1'
  version @_ver
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/gmmlib.git'
  git_hashtag "intel-gmmlib-#{@_ver}"

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gmmlib/22.3.1_x86_64/gmmlib-22.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '6d3b479fc5505fabc13d61b0b3e2a8ca929061cff0629ca57456ce828cbf337e'
  })

  depends_on 'libva'
  depends_on 'gcc' # R
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
