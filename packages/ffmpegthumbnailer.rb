require 'package'

class Ffmpegthumbnailer < Package
  description 'FFmpegthumbnailer is a lightweight video thumbnailer that can be used by file managers to create thumbnails for your video files.'
  homepage 'https://github.com/dirkvdb/ffmpegthumbnailer'
  version '2.2.0-1'
  compatibility 'all'
  source_url 'https://github.com/dirkvdb/ffmpegthumbnailer/releases/download/2.2.0/ffmpegthumbnailer-2.2.0.tar.bz2'
  source_sha256 'e5c31299d064968198cd378f7488e52cd5e738fac998eea780bc77d7f32238c2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpegthumbnailer-2.2.0-chromeos-aarch64.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpegthumbnailer-2.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpegthumbnailer-2.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpegthumbnailer-2.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '747253e634463bd56136959ba3d9af7a2471dab0b6ea25942c2393e63c8c2a32',
     armv7l: 'd87b2c125e50ecc2556594995889eba190dff239f3e3d9707f7cb73dc4a6adc8',
       i686: 'e47f302bf25775143bd1e7b0a62af36dfe734d7f9766c5e9a13c4eee54b69701',
     x86_64: '1ca2b6e0d414f56c48952814a8470e01c012d11434ab3c26fa28dfbb39b13890',
  })

  depends_on 'ffmpeg'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      if ARCH == 'x86_64'
        system "cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_GIO=ON -DENABLE_THUMBNAILER=ON -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DLIB_SUFFIX=64"
      else
        system "cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_GIO=ON -DENABLE_THUMBNAILER=ON -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
      end
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
