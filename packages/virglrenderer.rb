require 'buildsystems/meson'

class Virglrenderer < Meson
  description 'Virtual OpenGL renderer for QEMU virtual machines'
  homepage 'https://virgil3d.github.io/'
  version '1.3.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/virgl/virglrenderer.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '14fc96fd0ff1f35e5937a48d11ecccdeb087754ba925eb0978bf37c5919407d4',
     armv7l: '14fc96fd0ff1f35e5937a48d11ecccdeb087754ba925eb0978bf37c5919407d4',
     x86_64: '53db4fe36a74a79148ad84875cd6565f24517182d8210cc6fd41f8cb1e336968'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libdrm' => :library
  depends_on 'libepoxy' => :library
  depends_on 'libva' => :library
  depends_on 'libx11' => :library
  depends_on 'mesa' => :library
  depends_on 'minijail' => :library
  depends_on 'vulkan_icd_loader' => :library

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for
    # pre-M92 systems.
    return unless LIBC_VERSION < '2.28'

    downloader 'https://github.com/jtsiomb/c11threads/raw/a0158141b42ebe7a75aaf139e119e82453469125/c11threads.h',
               'c945fd352449174d3b6107c715b622206ebb81694ac23239637439d78e33ee5a', 'threads.h'
  end

  def self.prebuild
    system "meson setup #{CREW_MESON_OPTIONS.sub("-Dcpp_args='-O2'", '')} \
      -Drender-server-worker=minijail \
      -Dvideo=true \
      builddir"
  end
end
