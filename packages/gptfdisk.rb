require 'package'

class Gptfdisk < Package
  description 'GPT fdisk is a disk partitioning tool loosely modeled on Linux fdisk, but used for modifying GUID Partition Table (GPT) disks.'
  homepage 'https://sourceforge.net/projects/gptfdisk/'
  version '1.0.4'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/gptfdisk/files/gptfdisk/1.0.4/gptfdisk-1.0.4.tar.gz'
  source_sha256 'b663391a6876f19a3cd901d862423a16e2b5ceaa2f4a3b9bb681e64b9c7ba78d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e3374328c3134de08eae9bba3b47b18d8dc8198713105c32fb46e20e4bef0c0f',
     armv7l: 'e3374328c3134de08eae9bba3b47b18d8dc8198713105c32fb46e20e4bef0c0f',
       i686: '8293f7b22532b9328920b91e51ead9ec9f8b1575a4a51860b4d71785fde90218',
     x86_64: '94694d8c2f36d696c043bc1eb263f8baed2f05b419974aefeb70510d0980a058',
  })

  depends_on 'util_linux'
  depends_on 'popt'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.install Dir.glob("*gdisk"), "#{CREW_DEST_PREFIX}/bin/", :mode => 0755
    FileUtils.install "fixparts", "#{CREW_DEST_PREFIX}/bin/fixparts", :mode => 0755
    system "gzip -9 cgdisk.8 fixparts.8 gdisk.8 sgdisk.8"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man8/"
    FileUtils.install Dir.glob("*.8.gz"), "#{CREW_DEST_PREFIX}/share/man/man8/", :mode => 0644
  end
end
