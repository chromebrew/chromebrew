require 'package'

class Waypipe < Package
  description 'A proxy for Wayland protocol applications. WARNING: different versions are incompatible'
  homepage 'https://gitlab.freedesktop.org/mstoeckl/waypipe'
  version '0.7.2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mstoeckl/waypipe/-/archive/v0.7.2/waypipe-v0.7.2.tar.gz'
  source_sha256 'b280079b05aef9b243be3644fc803e3feaa2fc2952d11a6c02ab33257fb52479'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/waypipe-0.7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/waypipe-0.7.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/waypipe-0.7.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/waypipe-0.7.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '115949938eaf98fd38af6b1b8ffdb90e7976e87910fb5e0288d17c69d3cdb47c',
     armv7l: '115949938eaf98fd38af6b1b8ffdb90e7976e87910fb5e0288d17c69d3cdb47c',
       i686: '462f32367698388dd6333d14be082a20d1293102bfbb3ab5dfa9c8f55e42b3ea',
     x86_64: '3e2bfc20d665b49b6023b2f6d1e703e9bfce519a802ea8c8d8dde33e5a179640'
  })

  depends_on 'mesa'
  depends_on 'ffmpeg'
  depends_on 'libva'
  depends_on 'libdrm' => ':build'

  def self.patch
    system "sed -i '/#include \"util.h\"/a #include  <linux/version.h>' src/dmabuf.c"
    system "sed -i 's#defined(__FreeBSD__)#defined(__FreeBSD__) || LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)#g' src/dmabuf.c"
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
