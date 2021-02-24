require 'package'

class Gtksharp2 < Package
  description 'GTK2 bindings for mono'
  homepage 'https://www.mono-project.com/GtkSharp'
  version '2.12.45'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/gtk-sharp212/gtk-sharp-2.12.45.tar.gz'
  source_sha256 '02680578e4535441064aac21d33315daa009d742cab8098ac8b2749d86fffb6a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksharp2-2.12.45-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtksharp2-2.12.45-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtksharp2-2.12.45-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksharp2-2.12.45-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f7b0e0626a8561f4a24297d97322c2f4b280644e9b6015e03ce0d8a198bc2cfb',
     armv7l: 'f7b0e0626a8561f4a24297d97322c2f4b280644e9b6015e03ce0d8a198bc2cfb',
       i686: '8d3ee4c1e2fc91f85dbefae6ab26910e53ff5f57cbb9554489f6052c64160030',
     x86_64: '5215930d8372096829d725e24a500a3eb97387e390e621d145e05194c2570b5f'
  })

  depends_on 'mono'
  depends_on 'libglade'
  depends_on 'pango'
  depends_on 'atk'
  depends_on 'gtk2'
  depends_on 'glib'

  def self.patch
    @ambiguousrange = <<~PATCH_EOF
            --- a/sample/test/TestRange.cs
            +++ b/sample/test/TestRange.cs
            @@ -10,6 +10,10 @@
      #{' '}
             using Gtk;
      #{' '}
            +// disambiguate, Gtk.Range vs System.Range
            +using Range=Gtk.Range;
            +
            +
             namespace WidgetViewer {
      #{' '}
              public class TestRange
    PATCH_EOF
    IO.write('ambiguousrange.patch', @ambiguousrange)
    system 'patch -p 1 -i ambiguousrange.patch'
    system 'filefix'
  end

  def self.build
    system "CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
