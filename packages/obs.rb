require 'package'

class Obs < Package
  description 'Free and open source software for video recording and live streaming.'
  homepage 'https://obsproject.com/'
  version '24.0.5'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/obsproject/obs-studio/archive/24.0.5.tar.gz'
    source_sha256 'b3d65f36ad2bfcd6ffde1771be64662ce8e8771349fab82bb49f80dbb1f5f2e6'
    depends_on 'curl'
    depends_on 'ffmpeg'
    depends_on 'jack'
    depends_on 'jansson'
    depends_on 'libmbedtls'
    depends_on 'luajit'
    depends_on 'qtsvg'
    depends_on 'qtx11extras'
    depends_on 'v4l_utils'
    depends_on 'xdg_base'
    depends_on 'sommelier'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/obs-24.0.5-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/obs-24.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: 'b27299c233995f0c03a4dc2a8563bec7a2f00582a2554d62829d216769f42d5c',
    x86_64: '854492244415cea4b4874cf3cd2302649d5b538d89366f2fd1ccceda7ff1f3ea',
  })

  def self.build
    # Use the gold linker.
    old_ld = `ld_default g`.chomp
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
    # Restore the original linker.
    system 'ld_default', "#{old_ld}"
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    case ARCH
    when 'x86_64'
      Dir.chdir CREW_DEST_PREFIX do
        FileUtils.mv Dir.glob('lib/*'), 'lib64/'
      end
    end
  end

  def self.postinstall
    puts
    puts "To get started, type 'obs'.".lightblue
    puts
    puts "To completely remove, execute the following:".lightblue
    puts "crew remove obs".lightblue
    puts "rm -rf ~/.config/obs-studio/".lightblue
    puts
  end
end
