require 'package'

class Mypaint_brushes_1 < Package
  description 'Brushes used by MyPaint and other software using libmypaint.'
  homepage 'http://mypaint.org/'
  version '1.3.1'
  license 'CC0-1.0'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint-brushes.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint_brushes_1/1.3.1_armv7l/mypaint_brushes_1-1.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint_brushes_1/1.3.1_armv7l/mypaint_brushes_1-1.3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint_brushes_1/1.3.1_i686/mypaint_brushes_1-1.3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint_brushes_1/1.3.1_x86_64/mypaint_brushes_1-1.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd4c52770e79f9752640e1925d3da1bf273f86702a3dba5286ebdb8d9265363a1',
     armv7l: 'd4c52770e79f9752640e1925d3da1bf273f86702a3dba5286ebdb8d9265363a1',
       i686: '27d9d74494cb9b2b0adbf5224cf4f6303006d1699c02618a8b188f371349fd9d',
     x86_64: '2788325174fd8ba648a99146ad7feb6960eea153998ff175378cb758853f9056'
  })

  depends_on 'libmypaint'

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
