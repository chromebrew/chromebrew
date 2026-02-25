require 'package'

class Scite < Package
  description 'A free source code editing component for Win32, GTK+, and OS X'
  homepage 'https://www.scintilla.org/'
  version '5.5.9'
  license 'HPND and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.scintilla.org/scite#{version.gsub('.', '')}.tgz"
  source_sha256 'af7eb6299340e21462a386dadcdbca82e037fcd04ae6b0aa1b2af417c8bf4d71'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd523d840b5ad77e1fe63ddfdeb329c48d00134f76b7ac0b24a010fba86ef351e',
     armv7l: 'd523d840b5ad77e1fe63ddfdeb329c48d00134f76b7ac0b24a010fba86ef351e',
     x86_64: '3fc7d74fc6e9458a0c2b5e1e14e8d841704b39b3be02632a19f310348d70cec9'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnome_icon_theme'
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme'
  depends_on 'pango' # R
  depends_on 'shared_mime_info'
  depends_on 'sommelier' => :logical
  depends_on 'zlib' # R

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
