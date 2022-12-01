require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.21.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.21.0-1_armv7l/wayland-1.21.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.21.0-1_armv7l/wayland-1.21.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.21.0-1_i686/wayland-1.21.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.21.0-1_x86_64/wayland-1.21.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4a655aa1bab807fc82eaabc6c62489c0e0d576d1e16d01cebd536ba203d81832',
     armv7l: '4a655aa1bab807fc82eaabc6c62489c0e0d576d1e16d01cebd536ba203d81832',
       i686: 'b0c830aa7f4b7970b45b48b57b47ed4d765b2af6908ebf71e72f1814719bdd0e',
     x86_64: '27ef241ce34cc01b8a36ccd4ae4b7dc83e080d9e6c3fdb12a1d99a5303fddf15'
  })

  depends_on 'expat'
  depends_on 'libxml2'
  depends_on 'gcc'
  depends_on 'icu4c'
  depends_on 'zlibpkg'
  depends_on 'libffi'
  depends_on 'glibc' # R

  def self.build
    @wayland_env = <<~WAYLAND_ENV_EOF
      # environment set-up for Chrome OS built-in Wayland server
      set -a

      : "${XDG_RUNTIME_DIR:=/var/run/chrome}"
      : "${XDG_SESSION_TYPE:=wayland}"
      : "${WAYLAND_DISPLAY:=wayland-0}"
      : "${CLUTTER_BACKEND:=wayland}"
      : "${GDK_BACKEND:=wayland}"
      set +a
    WAYLAND_ENV_EOF

    system "meson setup #{CREW_MESON_OPTIONS} -Ddocumentation=false builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/etc/env.d/")
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/wayland", @wayland_env)
  end
end
