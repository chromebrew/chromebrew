require 'package'

class Freebasic < Package
  description 'FreeBASIC is a free/open source (GPL), BASIC compiler for Microsoft Windows, DOS and Linux.'
  homepage 'https://www.freebasic.net/'
  version '1.05.0'
  case ARCH
  when 'i686'
    source_url 'https://downloads.sourceforge.net/project/fbc/Binaries%20-%20Linux/FreeBASIC-1.05.0-linux-x86.tar.gz'
    source_sha256 'df20d3d11637d6f6173017dadf666d673133087189f8ecdb9756136f175e91b9'
  when 'x86_64'
    source_url 'https://downloads.sourceforge.net/project/fbc/Binaries%20-%20Linux/FreeBASIC-1.05.0-linux-x86_64.tar.gz'
    source_sha256 '26d184061e2a55c7ee9c12213ac4bf062556ecec1bacf84037233a41aef6c74f'
  else
    puts 'Unable to install freebasic.  Supported architectures include i686 and x86_64 only.'.lightred
  end

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freebasic-1.05.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freebasic-1.05.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '78d66a743264f37f605eaaf83fcbe612b52588928b200d89fe9227430dbf2dd8',
     x86_64: '3d289b59687e4a0fdba3272b290b3b638f1f2cf625ef14873e4e33e2acdd12aa',
  })

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'ncurses'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    FileUtils.cd("#{CREW_DEST_LIB_PREFIX}") do
      # This is needed to fix fbc: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory
      # See http://www.linuxforums.org/forum/installation/6251-libtinfo-so-5-a.html for more information.
      system "ln -s libncurses.so.6 libtinfo.so.5"
    end
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "./install.sh -i #{CREW_DEST_PREFIX}"
  end
end
