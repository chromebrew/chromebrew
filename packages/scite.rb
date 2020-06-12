require 'package'

class Scite < Package
  description 'A free source code editing component for Win32, GTK+, and OS X'
  homepage 'https://www.scintilla.org/'
  version '4.2.0'
  compatibility 'all'
  source_url 'https://www.scintilla.org/scite420.tgz'
  source_sha256 '2e0b95842bbc875a9224416fad3a9179ec329b3af2ca1abdd8e64c008068bb99'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/scite-4.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/scite-4.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/scite-4.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/scite-4.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '44c3738e5f6d241e74a0b2dc30080f73643cf170fcf93b8167a42f85943e4554',
     armv7l: '44c3738e5f6d241e74a0b2dc30080f73643cf170fcf93b8167a42f85943e4554',
       i686: 'b0e95f29a380e9fe2dc71216aa36c7902210f59f9041b92700c556c927e57049',
     x86_64: '1fcbc9d13a7c7bc5b7473631281fdea5302c8e55b88bdb8d25159b70890dfcec',
  })

  depends_on 'gtk3'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'shared_mime_info'
  depends_on 'sommelier'

  def self.build
    Dir.chdir 'scintilla/gtk' do
      system "make", "GTK3=1", "prefix=#{CREW_PREFIX}"
    end
    Dir.chdir 'scite/gtk' do
      system "make", "GTK3=1", "prefix=#{CREW_PREFIX}"
    end
  end

  def self.install
    Dir.chdir 'scite/gtk' do
      system "make", "GTK3=1", "prefix=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      system 'mv SciTE scite'
    end
    Dir.chdir "#{CREW_DEST_PREFIX}/share/applications" do
      system "sed -i 's,Exec=SciTE,Exec=scite,' SciTE.desktop"
    end
  end
end
