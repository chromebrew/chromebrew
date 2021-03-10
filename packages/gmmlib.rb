require 'package'

class Gmmlib < Package
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  @_ver = '20.4.1'
  version @_ver
  compatibility 'i686 x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url "https://github.com/intel/gmmlib/archive/intel-gmmlib-#{@_ver}.tar.gz"
    source_sha256 'd54d547f9f9e74196dead6a338923039ea10c859f1f693f33f10be1562b81d6d'
    depends_on 'libva'
  end

  binary_url({
    i686: 'https://dl.bintray.com/chromebrew/chromebrew/gmmlib-20.4.1-chromeos-i686.tar.xz',
  x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gmmlib-20.4.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: '216f1914cffe386625f78bc930046afa0d04f5254c555bd17fb433e70d161f17',
  x86_64: '7d846916ab47e45d4d85dc41c08c718d0c4e4e774769886f8b452af8b041de92'
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
            cmake #{CREW_CMAKE_OPTIONS} ../ -G Ninja"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
