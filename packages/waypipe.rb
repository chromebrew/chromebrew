require 'package'

class Waypipe < Package
  description 'A proxy for Wayland protocol applications. WARNING: different versions are incompatible'
  homepage 'https://gitlab.freedesktop.org/mstoeckl/waypipe'
  version '0.8.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mstoeckl/waypipe.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waypipe/0.8.0_armv7l/waypipe-0.8.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waypipe/0.8.0_armv7l/waypipe-0.8.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waypipe/0.8.0_i686/waypipe-0.8.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waypipe/0.8.0_x86_64/waypipe-0.8.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7ed1843341ca708c08c6ec854ece411d0dc4a2e37af472e8c11a75651c5beecc',
     armv7l: '7ed1843341ca708c08c6ec854ece411d0dc4a2e37af472e8c11a75651c5beecc',
       i686: '0c994fb5538080d055b0116fa26b65538e9b4f237b7be268b877df1c006ae408',
     x86_64: '96d33e96782fe12fb707271c66de01d3e5948a7c9d9fc59963bae8f33f19bf9f'
  })

  depends_on 'speexdsp' => :build
  depends_on 'ffmpeg' # R
  depends_on 'libdrm' => :build
  depends_on 'libva' # R
  depends_on 'mesa' # R

  def self.patch
    system "sed -i '/#include \"util.h\"/a #include  <linux/version.h>' src/dmabuf.c"
    system "sed -i 's#defined(__FreeBSD__)#defined(__FreeBSD__) || LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)#g' src/dmabuf.c"
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
