require 'package'

class Gtksharp2 < Package
  description 'GTK2 bindings for mono'
  homepage 'https://www.mono-project.com/GtkSharp'
  version '2.12.45'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/gtk-sharp212/gtk-sharp-2.12.45.tar.gz'
  source_sha256 '02680578e4535441064aac21d33315daa009d742cab8098ac8b2749d86fffb6a'

  depends_on 'mono'
  depends_on 'libglade'
  depends_on 'pango'
  depends_on 'atk'
  depends_on 'gtk2'
  depends_on 'glib'

  def self.patch
    @ambiguousrange = <<~EOF
      --- a/sample/test/TestRange.cs
      +++ b/sample/test/TestRange.cs
      @@ -10,6 +10,10 @@
 
       using Gtk;
 
      +// disambiguate, Gtk.Range vs System.Range
      +using Range=Gtk.Range;
      +
      +
       namespace WidgetViewer {
 
        public class TestRange
    EOF
    IO.write("ambiguousrange.patch", @ambiguousrange)
    system 'patch -p 1 -i ambiguousrange.patch'
  end
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --disable-maintainer-mode"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
