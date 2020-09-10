require 'package'

class Openvr < Package
  description 'OpenVR is an API and runtime that allows access to VR hardware from multiple vendors without requiring that applications have specific knowledge of the hardware they are targeting.'
  homepage 'https://github.com/ValveSoftware/openvr'
  version '1.12.5'
  compatibility 'all'
  source_url 'https://github.com/ValveSoftware/openvr/archive/v1.12.5.tar.gz'
  source_sha256 'f3cdbaa946688553638e6d65978f156311c9b08825316198d925f5eade6cfeb7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openvr-1.12.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openvr-1.12.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openvr-1.12.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openvr-1.12.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a76d1856f054658c6e2d6bc1eb32ee15331e7d2a06c136341d33262b1bce0930',
     armv7l: 'a76d1856f054658c6e2d6bc1eb32ee15331e7d2a06c136341d33262b1bce0930',
       i686: '91d3f788580791cdb59522621f37227b69974fad3a2ad52c72b2f956a36f06de',
     x86_64: '5cdd33423050168ac1704e498aa52fad652ca71c1060de4b7b8243b56807896f',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED=ON"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      case ARCH
      when 'x86_64'
        Dir.chdir CREW_DEST_PREFIX do
          FileUtils.mv 'lib/', 'lib64'
        end
      end
    end
  end
end
