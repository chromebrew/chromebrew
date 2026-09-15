require 'buildsystems/meson'

class Dconf < Meson
  description 'The DConf package contains a low-level configuration system.'
  homepage 'https://wiki.gnome.org/Projects/dconf'
  version '51.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/dconf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c0b832084df711f3a8f81cd2960c01cf9e4d5bd2fcd8b05915b5e8d89e2dc7f',
     armv7l: '9c0b832084df711f3a8f81cd2960c01cf9e4d5bd2fcd8b05915b5e8d89e2dc7f',
     x86_64: 'cf94dd8277eec499a7466e1070ef7181df23c021897ded4028df822b24c7a5f5'
  })

  depends_on 'bash_completion' => :build
  depends_on 'dbus' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'libxslt' => :library
  depends_on 'py3_gvdb' => :library
  depends_on 'vala' => :build

  gnome

  meson_install_extras do
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/lib/systemd"
  end
end
