require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/'
  @_ver = '3.43.1'
  version "#{@_ver}-py3.11"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.43.1-py3.11_armv7l/pygobject-3.43.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.43.1-py3.11_armv7l/pygobject-3.43.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.43.1-py3.11_i686/pygobject-3.43.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.43.1-py3.11_x86_64/pygobject-3.43.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8c9f546d17d1e57303a2541c4f00af5ca92214f89b6d5eccc7bba8f2629f8f5c',
     armv7l: '8c9f546d17d1e57303a2541c4f00af5ca92214f89b6d5eccc7bba8f2629f8f5c',
       i686: 'aa8f8c57783fb61d56379f679d6b526a5bdbad475135d1de923bcbabf4ad20fa',
     x86_64: '4a57c35deb72a415979a43651dc89ef4a4a91cdd99390cf8d7c653c5e3994644'
  })

  depends_on 'glib'
  depends_on 'wayland'
  depends_on 'gobject_introspection'
  depends_on 'py3_pycairo'
  depends_on 'python3' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libffi' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
