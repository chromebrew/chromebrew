require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.21.0'
  version @_ver.to_s
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.21.0_armv7l/wayland-1.21.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.21.0_armv7l/wayland-1.21.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.21.0_i686/wayland-1.21.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.21.0_x86_64/wayland-1.21.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '22d6cee271f0f480d15abcb2c6a8da1c827028c0a0ed7769c203bfccf4d6b19f',
     armv7l: '22d6cee271f0f480d15abcb2c6a8da1c827028c0a0ed7769c203bfccf4d6b19f',
       i686: 'b67a09052c16255f20eca0229c35fbc72a82249b4ecb7c2d3f5782a9048e66e0',
     x86_64: '3581887e7e979738b82a9c4aecc8677797bed0b7702192e65f508d7ba487c637'
  })

  depends_on 'expat'
  depends_on 'libxml2'
  depends_on 'gcc'
  depends_on 'icu4c'
  depends_on 'zlibpkg'
  depends_on 'libffi'

  def self.build
    @wayland_env = <<~WAYLAND_ENV_EOF
      # environment set-up for Chrome OS built-in Wayland server
      set -a

      : "${XDG_RUNTIME_DIR:=/var/run/chrome}"
      : "${XDG_SESSION_TYPE:=wayland}"
      : "${WAYLAND_DISPLAY:=wayland-0}"
      : "${CLUTTER_BACKEND:=wayland}"
      : "${GDK_BACKEND:=wayland}"
    WAYLAND_ENV_EOF

    system "meson #{CREW_MESON_OPTIONS} -Ddocumentation=false builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/etc/env.d/")
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/wayland", @wayland_env)
  end
end
