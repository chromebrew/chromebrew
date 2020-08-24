require 'package'

class Yajl < Package
  description 'A fast streaming JSON parsing library in C.'
  homepage 'http://lloyd.github.io/yajl/'
  version '2.1.0-2'
  compatibility 'all'
  source_url 'https://github.com/lloyd/yajl/archive/2.1.0.tar.gz'
  source_sha256 '3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yajl-2.1.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yajl-2.1.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yajl-2.1.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yajl-2.1.0-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4afb152584a025239161684888378662bc1305adccd63b5b5246581a914b74c8',
     armv7l: '4afb152584a025239161684888378662bc1305adccd63b5b5246581a914b74c8',
       i686: 'fab84163e9ddd02ec0286ccbad845005d376352f392e68bd57955b003c788d89',
     x86_64: 'f702d50a8e81b5fcfed7229a782aae5f03e45d85b0a386a24d152e3fac5ed595',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DCMAKE_C_FLAGS=' -fPIC' -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=Release"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      case ARCH
      when 'x86_64'
        Dir.chdir "#{CREW_DEST_PREFIX}" do
          FileUtils.mkdir 'lib64'
          FileUtils.mv Dir.glob('lib/*'), 'lib64/'
        end
      end
    end
  end
end
