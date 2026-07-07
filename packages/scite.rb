require 'package'

class Scite < Package
  description 'A free source code editing component for Win32, GTK+, and OS X'
  homepage 'https://www.scintilla.org/'
  version '5.6.4'
  license 'HPND and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.scintilla.org/scite#{version.gsub('.', '')}.tgz"
  source_sha256 'cf34c9e791c085f32562d5a3d6028935692ea3a93fcafa966bdf132955306a9c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f245e02c12d31c263bd01c390b80dbc576b2122288fda18faeb0005a6141fc98',
     armv7l: 'f245e02c12d31c263bd01c390b80dbc576b2122288fda18faeb0005a6141fc98',
     x86_64: '535938b118a5572391b227435dbd300558b3ca6d9a47fa45dd395ac7a3b329bd'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
