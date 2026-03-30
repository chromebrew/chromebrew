require 'package'

class Scite < Package
  description 'A free source code editing component for Win32, GTK+, and OS X'
  homepage 'https://www.scintilla.org/'
  version '5.6.1'
  license 'HPND and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.scintilla.org/scite#{version.gsub('.', '')}.tgz"
  source_sha256 '06e9dee41d2ffd67d6c4580cd1ca8eb543a12833cb5895ca50aec929c9194bf0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfb5ef1a6f3da57e8615ee4f3951dfdc78d9d1aa8d7c915fc0f43da9e4037148',
     armv7l: 'cfb5ef1a6f3da57e8615ee4f3951dfdc78d9d1aa8d7c915fc0f43da9e4037148',
     x86_64: 'ae8540ec972921087cc3907fd599baa8ef9135d29b359716a5894998795ef785'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gnome_icon_theme'
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'hicolor_icon_theme'
  depends_on 'pango' => :library
  depends_on 'shared_mime_info'
  depends_on 'sommelier' => :logical
  depends_on 'zlib' => :library

  def self.build
    Dir.chdir 'lexilla/src' do
      system 'make', "prefix=#{CREW_PREFIX}"
    end
    Dir.chdir 'scintilla/gtk' do
      system 'make', 'GTK3=1', "prefix=#{CREW_PREFIX}"
    end
    Dir.chdir 'scite/gtk' do
      system 'make', 'GTK3=1', "prefix=#{CREW_PREFIX}"
    end
  end

  def self.install
    Dir.chdir 'scite/gtk' do
      system 'make', 'GTK3=1', "prefix=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      system 'mv SciTE scite'
    end
    Dir.chdir "#{CREW_DEST_PREFIX}/share/applications" do
      system "sed -i 's,Exec=SciTE,Exec=scite,' SciTE.desktop"
    end
  end
end
