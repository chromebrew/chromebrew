require 'package'

class Scite < Package
  description 'A free source code editing component for Win32, GTK+, and OS X'
  homepage 'https://www.scintilla.org/'
  version '5.6.2'
  license 'HPND and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.scintilla.org/scite#{version.gsub('.', '')}.tgz"
  source_sha256 'f46a77b0d4972dc51c857bab3fe55a8e47cae481737359f93aef98ccca56de1d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53aa0c12c96e1c16b0392305c042d59d3f1258b5fdf19ab5f269bc8169ae976f',
     armv7l: '53aa0c12c96e1c16b0392305c042d59d3f1258b5fdf19ab5f269bc8169ae976f',
     x86_64: '316d3279a4bbf0bd25ce60dbde972d6dba95719acc9fb5a5c9c413633819ab65'
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
