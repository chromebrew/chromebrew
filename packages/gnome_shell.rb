require 'package'

class Gnome_shell < Package
  description 'Next generation desktop shell'
  homepage 'https://wiki.gnome.org/Projects/GnomeShell'
  version '41.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-shell.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_shell/41.0_armv7l/gnome_shell-41.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_shell/41.0_armv7l/gnome_shell-41.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_shell/41.0_x86_64/gnome_shell-41.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'eea813182b4fb943620beab82fabbdbde3b68cae8867ebc938e35c6a90612918',
     armv7l: 'eea813182b4fb943620beab82fabbdbde3b68cae8867ebc938e35c6a90612918',
     x86_64: '6afe54dadee75fb2a4b1794d68237ddcc17ac0eea5aafd679ae534d2b876f7cb'
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
  depends_on 'py3_pygments' => :build
  depends_on 'vulkan_icd_loader' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dgtk_doc=true \
    -Dsystemd=false \
    -Dnetworkmanager=false \
    -Dtests=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
