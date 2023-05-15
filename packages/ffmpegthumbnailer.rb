require 'package'

class Ffmpegthumbnailer < Package
  description 'FFmpegthumbnailer is a lightweight video thumbnailer that can be used by file managers to create thumbnails for your video files.'
  homepage 'https://github.com/dirkvdb/ffmpegthumbnailer'
  version '2.2.3-e0bf01d-1'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/dirkvdb/ffmpegthumbnailer.git'
  git_hashtag 'e0bf01d97e0261219b06d1e560e923354949b93e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpegthumbnailer/2.2.3-e0bf01d-1_armv7l/ffmpegthumbnailer-2.2.3-e0bf01d-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpegthumbnailer/2.2.3-e0bf01d-1_armv7l/ffmpegthumbnailer-2.2.3-e0bf01d-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpegthumbnailer/2.2.3-e0bf01d-1_x86_64/ffmpegthumbnailer-2.2.3-e0bf01d-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c3ba003434e1a2f7ccbeaf02f71857b16a037a2c47bfb19a2b8bf05d1900357f',
     armv7l: 'c3ba003434e1a2f7ccbeaf02f71857b16a037a2c47bfb19a2b8bf05d1900357f',
     x86_64: '52d11863520762477c41f80ac962e0fd361a31891da7f106af31ef6cbe9aef34'
  })

  depends_on 'ffmpeg' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -DENABLE_GIO=ON \
        -DENABLE_THUMBNAILER=ON \
        -Wno-dev \
        -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
