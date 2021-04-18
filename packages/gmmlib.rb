require 'package'

class Gmmlib < Package
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  @_ver = '21.1.1'
  version @_ver
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url "https://github.com/intel/gmmlib/archive/intel-gmmlib-#{@_ver}.tar.gz"
  source_sha256 'b996f09264e05ebca0dc275ea32791ba22769fe04147592371b4a61cdf508763'

  binary_url({
      i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gmmlib-21.1.1-chromeos-i686.tar.xz',
    x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gmmlib-21.1.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
      i686: 'c71cb96bf16648e0818daca7913e32a71a67a117ffaf1379f7e4970f075d5454',
    x86_64: '8cc86525354adbcc15e2e9ba8b59444178ec2037f72f9d29763286ef23dd1973'
  })

  depends_on 'libva'

  def self.patch
    system "find . -type f -exec sed -e 's,LD_LIBRARY_PATH=,LD_LIBRARY_PATH=#{CREW_LIB_PREFIX}:,g' \
            -e 's,-fstack-protector,-fno-stack-protector,g' -i {} +"
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
            CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
            LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
            cmake -G Ninja \
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
