require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.72.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.72.0_armv7l/glib-2.72.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.72.0_armv7l/glib-2.72.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.72.0_i686/glib-2.72.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.72.0_x86_64/glib-2.72.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '916c00b3ac163e3a526a2329eea9d0ef3008f72980208087741d9efc80418b00',
     armv7l: '916c00b3ac163e3a526a2329eea9d0ef3008f72980208087741d9efc80418b00',
       i686: 'ad226ebbe63163ec517a3340e7b7d658c8bdf5cf751533b189b784eea833a5fb',
     x86_64: 'b8ba6860034f65920bab6a302f237196058e394ea696835cb97f8a9e2af340f8'
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
