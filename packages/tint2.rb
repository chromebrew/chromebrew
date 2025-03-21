require 'package'

class Tint2 < Package
  description 'A lightweight panel/taskbar for Linux and BSD'
  homepage 'https://gitlab.com/o9000/tint2'
  version '16.7'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/o9000/tint2/-/archive/v16.7/tint2-v16.7.tar.gz'
  source_sha256 '74962c1dd111be9955319a133a790b24fe5a8ef0315a1bcdabc58c1157c1fb26'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a975a792b4d533bf2d64a776c20c8b9e5b9a4e6b1243e8206f6051f1afc02c77',
     armv7l: 'a975a792b4d533bf2d64a776c20c8b9e5b9a4e6b1243e8206f6051f1afc02c77',
     x86_64: '3ed565ee2eddc788b01dfa0e2a77d582646b80eb2ca56bc11384cc09e4e19324'
  })

  depends_on 'imlib2'
  depends_on 'gdk_pixbuf'

  ENV['CFLAGS'] = '-lX11 -lXau'
  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
