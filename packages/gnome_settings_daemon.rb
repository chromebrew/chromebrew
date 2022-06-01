require 'package'

class Gnome_settings_daemon < Package
  description 'GNOME Settings Daemon'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-settings-daemon'
  @_ver = '40.0.1'
  version @_ver
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l' # not compatible with i686 upstream
  source_url 'https://gitlab.gnome.org/GNOME/gnome-settings-daemon.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_settings_daemon/40.0.1_armv7l/gnome_settings_daemon-40.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_settings_daemon/40.0.1_armv7l/gnome_settings_daemon-40.0.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_settings_daemon/40.0.1_x86_64/gnome_settings_daemon-40.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '13be0d7f914c132310b6a5ccd7cfb9584269dac858a3cc61a46fcd63966cf425',
     armv7l: '13be0d7f914c132310b6a5ccd7cfb9584269dac858a3cc61a46fcd63966cf425',
     x86_64: '26646a35e2335da43548bcade06a0f1e609ee8eacfe1815c2ac6c07a2187355d'
  })

  depends_on 'dconf'
  depends_on 'gnome_desktop'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libcanberra'
  depends_on 'libnotify'
  depends_on 'libxslt' => :build
  depends_on 'networkmanager' => :build
  depends_on 'nss' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'geocode_glib'
  depends_on 'polkit'
  depends_on 'upower'
  depends_on 'libgweather'
  depends_on 'elogind'
  depends_on 'geoclue'
  depends_on 'gcr'

  # def self.patch
  ## Source has libgnome-volume-control repo as submodule
  # @git_dir = 'subprojects/gvc'
  # @git_hash = '7a621180b46421e356b33972e3446775a504139c'
  # @git_url = 'https://gitlab.gnome.org/GNOME/libgnome-volume-control.git'
  # FileUtils.rm_rf(@git_dir)
  # FileUtils.mkdir_p(@git_dir)
  # Dir.chdir @git_dir do
  # system 'git init'
  # system "git remote add origin #{@git_url}"
  # system "git fetch --depth 1 origin #{@git_hash}"
  # system 'git checkout FETCH_HEAD'
  # end
  # end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dsystemd=false \
    -Dcolord=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
