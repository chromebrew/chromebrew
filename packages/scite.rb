require 'package'

class Scite < Package
  description 'A free source code editing component for Win32, GTK+, and OS X'
  homepage 'https://www.scintilla.org/'
  version '5.5.4'
  license 'HPND and MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://www.scintilla.org/scite#{version.gsub('.', '')}.tgz"
  source_sha256 '439d033c452bb30bf7952e30390991a6abd022a031e8e74b25717f9e46ae90a8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c22e93f663185ecc128b1f6adaf5402306e87f5f37d898ec35f349b7d3bf9d78',
     armv7l: 'c22e93f663185ecc128b1f6adaf5402306e87f5f37d898ec35f349b7d3bf9d78',
     x86_64: 'b684675d163cc75cc3f631f201e1bbe95dfbb8eea58f97d1c4bdc8b981c1fc6d'
  })

  depends_on 'gtk3'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'shared_mime_info'
  depends_on 'sommelier'

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
