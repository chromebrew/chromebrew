# Adapted from Arch Linux mutter PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/mutter/trunk/PKGBUILD

require 'package'

class Mutter < Package
  description 'A window manager for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/mutter'
  version '40.beta'
  compatibility 'x86_64 , armv7l'
  source_url 'https://download.gnome.org/core/40/40.beta/sources/mutter-40.beta.tar.xz'
  source_sha256 '22aa7f8a57dbef865bc4e9b88f8fb91f45f18157d70f218199238bc10c25b1a6'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.beta-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6120122d259d3309e5244e06d793d67c7f41327ab1c177422adf0940c1f58c72',
     armv7l: '6120122d259d3309e5244e06d793d67c7f41327ab1c177422adf0940c1f58c72',
     x86_64: '213c59512a34b6fdc0f2e3f709be654c826742dc50ef20e3d796d92188914900'
  })

  depends_on 'dconf'
  depends_on 'gnome_settings_daemon'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'xorg_server' => ':build'
  depends_on 'libinput'
  depends_on 'libwacom'
  depends_on 'startup_notification'
  depends_on 'pipewire'
  depends_on 'libcanberra'
  depends_on 'ccache' => :build

  case ARCH
  when 'i686'

  end

  def self.patch
    case ARCH
    when 'i686'
      # Patch fixes meson dependency race condition
      # from https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/675#note_824519
      @getrandom_patch = <<~GETRANDOM_PATCH_EOF
                      diff --git a/src/wayland/meta-xwayland.c b/src/wayland/meta-xwayland.c
                      index 48fabbfb33..a45bb6df00 100644
                      --- a/src/wayland/meta-xwayland.c
                      +++ b/src/wayland/meta-xwayland.c
                      @@ -37,6 +37,17 @@
                       #include <sys/random.h>
                       #elif defined(HAVE_LINUX_RANDOM)
                       #include <linux/random.h>
                      +#elif NO_LINUX_RANDOM
                      +#include <sys/param.h>
                      +#include <fcntl.h>
                      +ssize_t getrandom(void *buf, size_t buflen, unsigned int flags) {
                      +int fd = open("/dev/random", O_CLOEXEC);
                      +if (fd < 0)
                      +  return -1;
                      +ssize_t bytes = read(fd, buf, buflen);
                      +close(fd);
                      +return bytes;
                      +}
                       #endif
                       #include <unistd.h>
                       #include <X11/extensions/Xrandr.h>
        #{'        '}
                      ---
                       meson.build | 2 +-
                       1 file changed, 1 insertion(+), 1 deletion(-)
                #{'      '}
                      diff --git a/meson.build b/meson.build
                      index 4becf2b7d6..a543faef0a 100644
                      --- a/meson.build
                      +++ b/meson.build
                      @@ -411,7 +411,7 @@ if have_wayland
                         elif cc.has_header_symbol('linux/random.h', 'getrandom')
                           cdata.set('HAVE_LINUX_RANDOM', 1)
                         else
                      -    error('Required function getrandom not found')
                      +    cdata.set('NO_LINUX_RANDOM', 1)
                         endif
                #{'       '}
                         # For Xwayland -initfd usage
      GETRANDOM_PATCH_EOF
      IO.write('getrandom.patch', @getrandom_patch)
      system 'patch -p1 -i getrandom.patch'
    end
  end

  case ARCH
  when 'x86_64', 'armv7l', 'aarch64'
    @opengl = 'true'
  when 'i686'
    @opengl = 'false'
  end

  def self.build
    # system "env CFLAGS='-fno-stack-protector' \
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dtests=false \
    -Dprofiler=false \
    -Dopengl=#{@opengl} \
    -Dglx=#{@opengl} \
    -Dwayland=#{@opengl} \
    -Dnative_backend=#{@opengl} \
    -Dcogl_tests=#{@opengl} \
    -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
