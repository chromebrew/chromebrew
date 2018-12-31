require 'package'

class Scite < Package
  description 'A free source code editing component for Win32, GTK+, and OS X'
  homepage 'https://www.scintilla.org/'
  version '4.1.2'
  source_url 'https://www.scintilla.org/scite412.tgz'
  source_sha256 '01eceecb4cfe80415bd1488900ada32340850cf3bba80f25f004da4811e3fcc8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/scite-4.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/scite-4.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/scite-4.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/scite-4.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '552468f6e1649d044e96ef8023c8bba8b04fd0fd5deec9c3e2c174427bf8c345',
     armv7l: '552468f6e1649d044e96ef8023c8bba8b04fd0fd5deec9c3e2c174427bf8c345',
       i686: '69d69f86e272e0855cf91748a02449beb7db7e0ef5adf04230402d8d7f17bef8',
     x86_64: 'a8c9d0bd57906313ba42997e72d377d69113ba3e88bb6add6df20f07f508961a',
  })

  depends_on 'gtk3'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'shared_mime_info'
  depends_on 'sommelier'
  depends_on 'libxcursor' 
  depends_on 'xcb_util_cursor'


  def self.build
    system 'wget https://www.scintilla.org/scintilla412.tgz'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('scintilla412.tgz') ) == '8c54787600fbefa5240ff3c4ac1c84fa186a445091377dde8194a4f1e1471d52'
    system 'tar xvf scintilla412.tgz'
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
