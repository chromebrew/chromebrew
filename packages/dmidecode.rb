require 'package'

class Dmidecode < Package
  description "Dmidecode reports information about your system's hardware as described in your system BIOS according to the SMBIOS/DMI standard (see a sample output)."
  homepage 'http://www.nongnu.org/dmidecode/'
  version '3.2'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/dmidecode/dmidecode-3.2.tar.xz'
  source_sha256 '077006fa2da0d06d6383728112f2edef9684e9c8da56752e97cd45a11f838edd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dmidecode-3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dmidecode-3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dmidecode-3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dmidecode-3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '41beef6535dc3a44b0e9485e304cb54143bb5be8b5fdb6fbed5e8e51089d9929',
     armv7l: '41beef6535dc3a44b0e9485e304cb54143bb5be8b5fdb6fbed5e8e51089d9929',
       i686: 'b8c0de1cfdbe60df43f545a1d057860ef53eac548284b04ecb58c532077470d9',
     x86_64: 'fef3f3b044cf9a7e00678b1a8eee3881611f92053af7da334f1cffcab88b7772',
  })

  def self.patch
    system "sed -i 's,^prefix = /usr/local,prefix = #{CREW_PREFIX},' Makefile"
    case ARCH
    when 'aarch64', 'armv7l'
      system "sed -i '55iPROGRAMS-#{ARCH} := biosdecode ownership vpddecode' Makefile"
      system "sed -i 's,#CFLAGS += -DBIGENDIAN,CFLAGS += -DBIGENDIAN,' Makefile"
      system "sed -i 's,#CFLAGS += -DALIGNMENT_WORKAROUND,CFLAGS += -DALIGNMENT_WORKAROUND,' Makefile"
    end
  end

  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To report information about the system hardware, execute the following:".lightblue
    puts "sudo dmidecode".lightblue
    puts
  end
end
