require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.22.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.22.0_armv7l/wayland-1.22.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.22.0_armv7l/wayland-1.22.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.22.0_i686/wayland-1.22.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.22.0_x86_64/wayland-1.22.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '72e4522abfc219a7f20f7894dcbeb3efe1f630ddda000131df9ba827e5547d13',
     armv7l: '72e4522abfc219a7f20f7894dcbeb3efe1f630ddda000131df9ba827e5547d13',
       i686: 'a5be6452a0bbd9aeb09ba960449c1690e9a0cbcfafdb2283ef6a02a2e1416025',
     x86_64: '1fc209aa34fa165f41a6100dad83c352c5bfb5662bc37b279ce6091052edc90b'
  })

  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' => :build
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'zlibpkg' => :build

  def self.build
    File.write 'waylandenv', <<~WAYLAND_ENV_EOF
      # environment set-up for Chrome OS built-in Wayland server
      : "${XDG_RUNTIME_DIR:=/var/run/chrome}"
      : "${XDG_SESSION_TYPE:=wayland}"
      : "${WAYLAND_DISPLAY:=wayland-0}"
      : "${CLUTTER_BACKEND:=wayland}"
      : "${GDK_BACKEND:=wayland}"
    WAYLAND_ENV_EOF
    system "meson setup #{CREW_MESON_OPTIONS} -Ddocumentation=false builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.install 'waylandenv', "#{CREW_DEST_PREFIX}/etc/env.d/wayland", mode: 0o644
  end
end
