require 'package'

class Peek < Package
  description 'Simple animated GIF screen recorder with an easy to use interface'
  homepage 'https://github.com/phw/peek'
  version '1.3.1'
  compatibility 'all'
  source_url 'https://github.com/phw/peek/archive/1.3.1.tar.gz'
  source_sha256 '8104b65b041858b7f7f482e1425f8f22d429524340ad341f95f08b08fe4e8602'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/peek-1.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/peek-1.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/peek-1.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/peek-1.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c24c16aff4c322c206f4b6a6d2e0d9d87d0f88aadf7ff95bc09fce9ef2958281',
     armv7l: 'c24c16aff4c322c206f4b6a6d2e0d9d87d0f88aadf7ff95bc09fce9ef2958281',
       i686: '093c78bb96a25e6b2400575ff90ba7ddf57288a5ad83ddcba4da79e454f20709',
     x86_64: '15a73e027a0d2b9b1924b15d39c79625960f6a60556032d0974e868d0e228158',
  })

  depends_on 'ffmpeg'
  depends_on 'gtk3'
  depends_on 'vala'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'peek'
    Dir.chdir 'peek' do
      system 'cmake',
             "-DCMAKE_BUILD_TYPE=Release",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'peek' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "update-mime-database #{CREW_PREFIX}/share/mime"
  end
end
