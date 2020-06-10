require 'package'

class Aqemu < Package
  description 'AQEMU is a GUI for virtual machines using QEMU as the backend.'
  homepage 'https://sourceforge.net/projects/aqemu/'
  version '0.9.2'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://downloads.sourceforge.net/project/aqemu/aqemu/0.9.2/aqemu-0.9.2.tar.gz'
    source_sha256 'e3d54de00ebdce3754f97f7e0e7cce8cebb588e8ce6bc249401cc909281b08de'
    depends_on 'libvncserver'
    depends_on 'qemu'
    depends_on 'qtbase'
    depends_on 'xdg_base'
    depends_on 'sommelier'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aqemu-0.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aqemu-0.9.2-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aqemu-0.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9b660d4e0ed420f0a74c5df33e7221042fc87764d9f8e70856a1aa31d14ea71c',
     armv7l: '9b660d4e0ed420f0a74c5df33e7221042fc87764d9f8e70856a1aa31d14ea71c',
     x86_64: '99544f65ac97a48e5f7e4c25eb26113db8301b25a5bbdd41d2fbfe52a5bdcd26',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DMAN_PAGE_COMPRESSOR=gzip",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.postinstall
    puts
    puts "Type 'aqemu' to execute.".lightblue
    puts
    puts "To completely uninstall, execute the following:".lightblue
    puts "crew remove aqemu".lightblue
    puts "rm -rf ~/.aqemu".lightblue
    puts
  end
end
