require 'package'

class Gnome_settings_daemon < Package
  description 'GNOME Settings Daemon'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-settings-daemon'
  @_ver = '40.0'
  version @_ver
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/archive/#{@_ver}/gnome-settings-daemon-#{@_ver}.tar.bz2"
  source_sha256 'ea6351b9f82c507e431cea15a69e7bb0574b8003618c48ff8c07e04969516e7f'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gnome_settings_daemon-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gnome_settings_daemon-40.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gnome_settings_daemon-40.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gnome_settings_daemon-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ae054caa58411bbf1f00729e748aaf0974913bff99ff77d24797f3814e4c5387',
     armv7l: 'ae054caa58411bbf1f00729e748aaf0974913bff99ff77d24797f3814e4c5387',
       i686: '90a5725eb84e76c5a23bd80fb670a569e63315a6ae8a599ef92cf8ec499f3aec',
     x86_64: '294b8c533a037a62c14971e49d909b5a48c62b7717734bdc3b0ab20ee981be11'
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

  def self.patch
    # Source has libgnome-volume-control repo as submodule
    @git_dir = 'subprojects/gvc'
    @git_hash = '7a621180b46421e356b33972e3446775a504139c'
    @git_url = 'https://gitlab.gnome.org/GNOME/libgnome-volume-control.git'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
  end

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
