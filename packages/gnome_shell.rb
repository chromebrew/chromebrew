require 'package'

class Gnome_shell < Package
  description 'Next generation desktop shell'
  homepage 'https://wiki.gnome.org/Projects/GnomeShell'
  version '40.3'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-shell.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_shell/40.3_armv7l/gnome_shell-40.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_shell/40.3_armv7l/gnome_shell-40.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_shell/40.3_x86_64/gnome_shell-40.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a77bce5ae1cffd7a7a159730565b7308442d44a8ad2fcce5367caa9683d07ff6',
     armv7l: 'a77bce5ae1cffd7a7a159730565b7308442d44a8ad2fcce5367caa9683d07ff6',
     x86_64: '26f505c184e1277fba828dd0258845bed34a42d62c0dc19862f0698d1b2113de'
  })

  depends_on 'gcr'
  depends_on 'gjs'
  depends_on 'ibus'
  depends_on 'mutter'
  depends_on 'sassc'
  depends_on 'asciidoc'
  depends_on 'startup_notification'
  depends_on 'gnome_autoar'
  depends_on 'upower'
  depends_on 'gnome_session'
  depends_on 'gnome_settings_daemon'
  depends_on 'gtk_doc' => :build
  depends_on 'evolution_data_server' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'mutter'
  depends_on 'pygments' => :build
  depends_on 'vulkan_icd_loader' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dgtk_doc=true \
    -Dsystemd=false \
    -Dnetworkmanager=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
