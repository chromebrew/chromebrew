require 'package'

class Waypipe < Package
  description 'A proxy for Wayland protocol applications. WARNING: different versions are incompatible'
  homepage 'https://gitlab.freedesktop.org/mstoeckl/waypipe'
  version '0.8.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mstoeckl/waypipe.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waypipe/0.8.4_armv7l/waypipe-0.8.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waypipe/0.8.4_armv7l/waypipe-0.8.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waypipe/0.8.4_i686/waypipe-0.8.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waypipe/0.8.4_x86_64/waypipe-0.8.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e188ef809cb986bd1550de0a434c92df6458b360e13b423864704de05114c7fa',
     armv7l: 'e188ef809cb986bd1550de0a434c92df6458b360e13b423864704de05114c7fa',
       i686: 'db973f5765ec2b971f4618a1e17115383c28fd6d97b51b6cb95f4387551769cb',
     x86_64: 'ce9eceed169b2707a12e55ca318466611f29d18c2f7705a13df33f80fe8c00e0'
  })

  depends_on 'speexdsp' => :build
  depends_on 'ffmpeg' # R
  depends_on 'libdrm' => :build
  depends_on 'libva' # R
  depends_on 'mesa' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'zstd' # R
  depends_on 'gcc' # R

  def self.build
    system "CC=clang LD=mold meson setup #{CREW_MESON_OPTIONS.gsub('-ffat-lto-objects', '').gsub('-fuse-ld=mold', '')} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
