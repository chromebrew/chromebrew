require 'package'

class Tepl_6 < Package
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://wiki.gnome.org/Projects/Tepl'
  version '6.0.0.0'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/Archive/tepl.git'
  git_hashtag version

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tepl_6/5.99.0-d61f_i686/tepl_6-5.99.0-d61f-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tepl_6/6.0.0.0_armv7l/tepl_6-6.0.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tepl_6/6.0.0.0_armv7l/tepl_6-6.0.0.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tepl_6/6.0.0.0_x86_64/tepl_6-6.0.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: 'f98b0034642f3433f036107d710f7c466701f94cea809e83908ada8c98305bc2',
    aarch64: '91d6926ec63368229ac7526d719d15d1e2ae9b5cdb4e6046519792a7ce8f5a8a',
     armv7l: '91d6926ec63368229ac7526d719d15d1e2ae9b5cdb4e6046519792a7ce8f5a8a',
     x86_64: 'cb6aa557f538e25b3b9dff15ec7b02699b8efc13e76749d4b262406b541b577d'
  })

  depends_on 'amtk'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
