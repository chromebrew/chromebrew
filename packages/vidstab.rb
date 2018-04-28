require 'package'

class Vidstab < Package
  description 'Transcode video stabilization plugin.'
  homepage 'http://public.hronopik.de/vid.stab/'
  version '1.1.0'
  source_url 'https://github.com/georgmartius/vid.stab/archive/v1.1.0.tar.gz'
  source_sha256 '14d2a053e56edad4f397be0cb3ef8eb1ec3150404ce99a426c4eb641861dc0bb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-1.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bce661392dce20dd457aac266b8fd54d9baab87d817f5975ab6705950b77a272',
     armv7l: 'bce661392dce20dd457aac266b8fd54d9baab87d817f5975ab6705950b77a272',
       i686: '68014e89423663b16267d08d5cb2342356f81eeb92cad863a6a97d8b536466d8',
     x86_64: '3557c98666d254d12bd738595ea6147dea7f7b354a24bd246832084fe1bcddb6',
  })

  def self.build
    system "cmake . -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
