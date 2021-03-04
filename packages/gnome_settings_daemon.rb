require 'package'

class Gnome_settings_daemon < Package
  description 'GNOME Settings Daemon'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-settings-daemon'
  version '40.beta'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/40/40.beta/sources/gnome-settings-daemon-40.beta.tar.xz'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_settings_daemon-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_settings_daemon-40.beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_settings_daemon-40.beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_settings_daemon-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '089b400c60fa5649fbccf332972501766a7f79085ca20c952aeb5319644defe0',
     armv7l: '089b400c60fa5649fbccf332972501766a7f79085ca20c952aeb5319644defe0',
       i686: '65a330c824166575f3190da5f651945cdc37eb9c6e9a86e75fe00fad599708c8',
     x86_64: '74cd5aab21d63c98297acb71cdf967659a876a221f12cd3d627b62f5672a1aa7'
  })

  depends_on 'dconf'
  depends_on 'gnome_desktop'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libcanberra'
  depends_on 'libnotify'
  depends_on 'libxslt' => ':build'
  depends_on 'docbook_xsl' => ':build'
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
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
