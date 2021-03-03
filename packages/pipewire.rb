require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  @_ver = '0.3.22'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/PipeWire/pipewire/archive/#{@_ver}.tar.gz"
  source_sha256 '5db2caf41af79cd9e343d07a3804c63b8b243c1d74e926181058e29771d4b691'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.22-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.22-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.22-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '8641411382ca539208681a9fcc0e4c4449c317020c28a7f95a1b4d3fee6a04a4',
      armv7l: '8641411382ca539208681a9fcc0e4c4449c317020c28a7f95a1b4d3fee6a04a4',
        i686: 'd8d093f9cabf7881daaa746af3c7d0a44604c55caf732272a04817b8593bf2ba',
      x86_64: 'af44f8765b24d423555db5ac00324c8c73c597144af404a28551bbcae595a405',
  })


  depends_on 'gsettings_desktop_schemas'
  depends_on 'alsa_plugins' => :build
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'jack'
  depends_on 'eudev'
  depends_on 'vulkan_headers'
  depends_on 'mesa'

  def self.patch
    case ARCH
    when 'i686'
      # Patch from https://gitlab.freedesktop.org/pipewire/pipewire/-/commit/9f53057b51c9d7ce68c240c21b459dc0b7d6acaf
      # getrandom was introduced to glibc 2.25, and i686 has 2.23.
      @getrandom_freebsd = <<~'GETRANDOM_FREEBSD_EOF'
        #include <sys/param.h>
        #include <fcntl.h>
        ssize_t getrandom(void *buf, size_t buflen, unsigned int flags) {
          int fd = open("/dev/random", O_CLOEXEC);
          if (fd < 0)
            return -1;
          ssize_t bytes = read(fd, buf, buflen);
          close(fd);
          return bytes;
        }
      GETRANDOM_FREEBSD_EOF
      IO.write('getrandom.c', @getrandom_freebsd)
      system "sed -i '/random.h/ r getrandom.c' src/pipewire/impl-core.c"
      system "sed -i '/random.h/d' src/pipewire/impl-core.c"
    end
  end

  def self.build
    system "meson \
      #{CREW_MESON_LTO_OPTIONS} \
      -Dbluez5=false \
      -Dbluez5-backend-native=false \
      -Dbluez5-backend-ofono=false \
      -Dbluez5-backend-hsphfpd=false \
      -Dvulkan=true \
      -Dv4l2=false \
      -Dexamples=false \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev/rules.d \
      -Dvolume=true \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
