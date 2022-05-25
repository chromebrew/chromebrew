require 'package'

class Virglrenderer < Package
  description 'Virtual OpenGL renderer for QEMU virtual machines'
  homepage 'https://virgil3d.github.io/'
  version '0.9.1-486d891'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/virgl/virglrenderer.git'
  git_hashtag '486d891a9242d978cef6bb5ae80d0d9b6aa420c8'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/virglrenderer/0.9.1-486d891_armv7l/virglrenderer-0.9.1-486d891-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/virglrenderer/0.9.1-486d891_armv7l/virglrenderer-0.9.1-486d891-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/virglrenderer/0.9.1-486d891_x86_64/virglrenderer-0.9.1-486d891-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '662b56e9402ba14b88877a5d05ee968f7912236115fc489228da21bf79802495',
     armv7l: '662b56e9402ba14b88877a5d05ee968f7912236115fc489228da21bf79802495',
     x86_64: 'b50b3677447bd9385bdc2eeab64a5c88cbaa9d2e63a1266826d170dcce2e1bd1'
  })

  depends_on 'libva'
  depends_on 'mesa'
  depends_on 'minijail'
  depends_on 'libepoxy'
  depends_on 'vulkan_icd_loader'

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for
    # pre-M92 systems.
    return unless LIBC_VERSION < '2.28'

    downloader 'https://github.com/jtsiomb/c11threads/raw/a0158141b42ebe7a75aaf139e119e82453469125/c11threads.h',
               'c945fd352449174d3b6107c715b622206ebb81694ac23239637439d78e33ee5a', 'threads.h'
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS.sub("-Dcpp_args='-O2'", '')} \
      -Ddrm-msm-experimental=true \
      -Dvenus-experimental=true \
      -Drender-server=true \
      -Drender-server-worker=minijail \
      -Dvideo=true \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
