require 'package'

class Gmmlib < Package
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  @_ver = '22.2.0'
  version @_ver
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/gmmlib.git'
  git_hashtag "intel-gmmlib-#{@_ver}"

  binary_url({
    x86_64: 'file:///usr/local/tmp/packages/gmmlib-22.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: 'b9e65594d3579bd7a3a72c477c7ccdc21a83bcdfa24f2e49336df1e3d22a32f8'
  })

  depends_on 'libva'

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake -G Ninja \
            #{CREW_CMAKE_OPTIONS} \
            -DRUN_TEST_SUITE=OFF \
            .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
