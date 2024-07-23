require 'package'

class Igt_gpu_tools < Package
  description 'Tools for development and testing of the Intel DRM driver'
  homepage 'https://gitlab.freedesktop.org/drm/igt-gpu-tools'
  @_ver = '1.25'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://xorg.freedesktop.org/releases/individual/app/igt-gpu-tools-#{@_ver}.tar.xz"
  source_sha256 '40454d8f0484ea2477862007398a08eef78a6c252c4defce1c934548593fdd11'
  binary_compression 'tar.xz'

  binary_sha256({
    x86_64: '72bfc16dbd9532d049a67a8a8c328b50d8f5764f6922445bfe9899129735fcd1'
  })

  depends_on 'libdrm'
  depends_on 'libpciaccess'
  depends_on 'cairo'
  depends_on 'libxrandr'
  depends_on 'procps'
  depends_on 'libkmod'
  depends_on 'libxv'
  depends_on 'libunwind'
  depends_on 'peg'
  depends_on 'swig' => :build
  depends_on 'gtk_doc' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Ddocs=disabled \
    -Dtests=disabled \
    -Doping=disabled \
    -Drunner=disabled \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
