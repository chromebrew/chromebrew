require 'package'

class Libgd < Package
  description 'GD is an open source code library for the dynamic creation of images by programmers.'
  homepage 'https://libgd.github.io/'
  version '2.2.5'
  source_url 'https://github.com/libgd/libgd/archive/gd-2.2.5.tar.gz'
  source_sha256 '199874fdb006de0911819234104ffa84338e98e82fefbac042a58a3f8272a7df'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.2.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.2.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e7f9d0fe0c1ea968a4c18cd47277fc80ac04bd4b53a5bb16fd7ed146d638266d',
     armv7l: 'e7f9d0fe0c1ea968a4c18cd47277fc80ac04bd4b53a5bb16fd7ed146d638266d',
       i686: 'f50d37624fa239829735acef46ba4c96972df68dba9cca4df480af38004e9168',
     x86_64: 'a3497051dc1dfe8cbc764d21097288bf49a491688e4f960ac41d11c1f6d39942',
  })

  depends_on 'cmake'
  depends_on 'libpng'

  def self.build
    FileUtils.mkdir('build')
    FileUtils.cd('build') do
      system "cmake -DCMAKE_INCLUDE_PATH=#{CREW_PREFIX}/include -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} .."
      system "make"
    end
  end

  def self.install
    FileUtils.cd('build') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
