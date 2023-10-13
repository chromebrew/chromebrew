require 'package'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  @_ver = '1.50.14'
  version "#{@_ver}-1"
  license 'LGPL-2+ and FTL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14-1_armv7l/pango-1.50.14-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14-1_armv7l/pango-1.50.14-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14-1_x86_64/pango-1.50.14-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '223a3d19029d1a31182fc300d346108ca9b9540fafc314e8783de62405cef8b5',
     armv7l: '223a3d19029d1a31182fc300d346108ca9b9540fafc314e8783de62405cef8b5',
     x86_64: '05fe571aa075b48305b79ccf41adce94b0f53a4a0c4ccbd757897c5dca40abc8'
  })

  depends_on 'cairo' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build # add this package to build gtk+, avoid compilation error
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxdmcp' => :build
  depends_on 'libxft' # R
  depends_on 'libxrender' # R
  depends_on 'xorg_proto' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dinstall-tests=false \
      -Dcairo=enabled \
      -Dfreetype=enabled \
      -Dfontconfig=enabled \
      -Dlibthai=disabled \
      -Dgtk_doc=false \
      builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
