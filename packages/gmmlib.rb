require 'package'

class Gmmlib < Package
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  @_ver = '21.2.1'
  version @_ver
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/gmmlib.git'
  git_hashtag "intel-gmmlib-#{@_ver}"

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gmmlib/21.2.1_x86_64/gmmlib-21.2.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: '99d879841a2c3d0d9d02438ae37720bec7b02f68ba177b52992b0fac6092bf1d'
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
