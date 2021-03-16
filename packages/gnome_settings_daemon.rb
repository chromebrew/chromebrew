require 'package'

class Gnome_settings_daemon < Package
  description 'GNOME Settings Daemon'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-settings-daemon'
  @_ver = '40.rc'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/archive/#{@_ver}/gnome-settings-daemon-#{@_ver}.tar.bz2"
  source_sha256 'dc057f3c73112bae2b74207bf764258019acd2f40109a43ee163b95feceb9187'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_settings_daemon-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_settings_daemon-40.rc-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_settings_daemon-40.rc-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_settings_daemon-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8e7277690364585e888e6accfddb83baf15c3c8d66ce70c050aac68949ea5af5',
     armv7l: '8e7277690364585e888e6accfddb83baf15c3c8d66ce70c050aac68949ea5af5',
       i686: 'e9ba7c3c497d399bf6ab0230c31aa1accd6399cfa14cf20d0c5e23096207ce49',
     x86_64: '2c92223eb1a97973cdd4d3b0be828be63ac17103afa72004bc6c3dcc07adbe48'
  })

  depends_on 'dconf'
  depends_on 'gnome_desktop'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libcanberra'
  depends_on 'libnotify'
  depends_on 'libxslt' => ':build'
  depends_on 'networkmanager' => ':build'
  depends_on 'nss' => ':build'
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
