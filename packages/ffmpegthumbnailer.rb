require 'package'

class Ffmpegthumbnailer < Package
  description 'FFmpegthumbnailer is a lightweight video thumbnailer that can be used by file managers to create thumbnails for your video files.'
  homepage 'https://github.com/dirkvdb/ffmpegthumbnailer'
  version '2.2.3-e0bf01d'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/dirkvdb/ffmpegthumbnailer.git'
  git_hashtag 'e0bf01d97e0261219b06d1e560e923354949b93e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpegthumbnailer/2.2.3-e0bf01d_armv7l/ffmpegthumbnailer-2.2.3-e0bf01d-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpegthumbnailer/2.2.3-e0bf01d_armv7l/ffmpegthumbnailer-2.2.3-e0bf01d-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpegthumbnailer/2.2.3-e0bf01d_i686/ffmpegthumbnailer-2.2.3-e0bf01d-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpegthumbnailer/2.2.3-e0bf01d_x86_64/ffmpegthumbnailer-2.2.3-e0bf01d-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '52ce4e6f607f33c56bbc51ab712de2181b9b050074ca4da1bc3eefc244a35ccf',
     armv7l: '52ce4e6f607f33c56bbc51ab712de2181b9b050074ca4da1bc3eefc244a35ccf',
       i686: '1cae20f661e2429b2753dc1d06caa34ef4f9956df354569b14003ed0f146f17d',
     x86_64: 'ea211b71290b0db4db405ad4b902a6bbb1ddc78ada453375817466661dc11e33'
  })

  depends_on 'ffmpeg'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake #{CREW_CMAKE_OPTIONS} \
              -DENABLE_THUMBNAILER=ON \
              -DENABLE_GIO=ON .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
