require 'package'

class Rest < Package
  description 'Helper library for RESTful services'
  homepage 'https://wiki.gnome.org/Projects/Librest'
  version '0.9.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/librest/-/archive/#{version}/librest-#{version}.tar.bz2"
  source_sha256 '5c39f6696b271194546880e0f360e21496b2882f72e4bb85433125de98fce03a'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rest/0.9.1_armv7l/rest-0.9.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rest/0.9.1_armv7l/rest-0.9.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rest/0.9.1_i686/rest-0.9.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rest/0.9.1_x86_64/rest-0.9.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '519192ae5947606899084ab33c89aeffc03e6a21602742a155405dc61bb00c2a',
     armv7l: '519192ae5947606899084ab33c89aeffc03e6a21602742a155405dc61bb00c2a',
       i686: '9ed1544bbbd58684711f310dfa7b3621bc1a518161de770d690b00193120e10b',
     x86_64: 'dcb417551add89f25c24a9f3cdcd3f43c4fa0ac78606775fe252dd6662d3056c'
  })

  depends_on 'glib'
  depends_on 'libsoup'
  depends_on 'libadwaita'
  depends_on 'librsvg'
  depends_on 'gtksourceview_5'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_toml' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'py3_typogrify' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'vulkan_icd_loader' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'mold -run samu -C builddir'
  end

  def self.check
    system 'ninja test -C builddir || true'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
