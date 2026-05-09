require 'buildsystems/meson'

class Dconf < Meson
  description 'The DConf package contains a low-level configuration system.'
  homepage 'https://wiki.gnome.org/Projects/dconf'
  version '0.49.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/dconf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f415cdeda2116ba03a4ef6ea72cd4db30677240f9bce632aa49e80466e824e39',
     armv7l: 'f415cdeda2116ba03a4ef6ea72cd4db30677240f9bce632aa49e80466e824e39',
     x86_64: '8159f9ea61b1f469049e292cbf1732631b2a723343e14736079880062b77c1f5'
  })

  depends_on 'bash_completion' => :build
  depends_on 'dbus' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'libxslt' => :library
  depends_on 'py3_gvdb' => :library
  depends_on 'vala' => :build

  gnome

  meson_install_extras do
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/lib/systemd"
  end
end
