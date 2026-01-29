require 'package'

class Scite < Package
  description 'A free source code editing component for Win32, GTK+, and OS X'
  homepage 'https://www.scintilla.org/'
  version '5.5.8'
  license 'HPND and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.scintilla.org/scite#{version.gsub('.', '')}.tgz"
  source_sha256 'abd5eec4f97de9d746bca0f719b89ccb84a1c7ee5bd37fecc4b8c913b6968d21'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9cb2da5f18b166080a39395dd4763f8b5cd0b89df4a2e0162000e512299012d5',
     armv7l: '9cb2da5f18b166080a39395dd4763f8b5cd0b89df4a2e0162000e512299012d5',
     x86_64: '2f1b5a02ebae0a0247fc1c9a898343a71990205e09defd7d58455fbdb1de8f82'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnome_icon_theme'
  depends_on 'gtk3'
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
