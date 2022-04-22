require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.72.1'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.72.1_armv7l/glib-2.72.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.72.1_armv7l/glib-2.72.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.72.1_i686/glib-2.72.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.72.1_x86_64/glib-2.72.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2c56eed09d770f2dcf68f47bdd26923ae00306cb3b8c0cbed41f0f819d582d35',
     armv7l: '2c56eed09d770f2dcf68f47bdd26923ae00306cb3b8c0cbed41f0f819d582d35',
       i686: '8b73a5befbfc7b7c2e2e88a18f684ae9c5005182aff3f19ec05e1cc491a7f65e',
     x86_64: 'e26b9b49b5bfcbfc0188fd32c69d02ed9345633011b3ed56fa803d55ea5a65b1'
  })

  depends_on 'elfutils' # R
  depends_on 'libffi' # R
  depends_on 'pcre' # R
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R
  no_env_options
  patchelf
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
