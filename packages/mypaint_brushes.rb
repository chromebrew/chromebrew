require 'package'

class Mypaint_brushes < Package
  description 'Brushes used by MyPaint and other software using libmypaint.'
  homepage 'http://mypaint.org/'
  version '2.0.2'
  license 'CC0-1.0'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint-brushes.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint_brushes/2.0.2_armv7l/mypaint_brushes-2.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint_brushes/2.0.2_armv7l/mypaint_brushes-2.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint_brushes/2.0.2_i686/mypaint_brushes-2.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint_brushes/2.0.2_x86_64/mypaint_brushes-2.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dd1cc71b20fd4b128b5e4c5d0122b3cad0b5aefdb14fe79d57fda90d14c91265',
     armv7l: 'dd1cc71b20fd4b128b5e4c5d0122b3cad0b5aefdb14fe79d57fda90d14c91265',
       i686: '83df0466434ec9188e356fdb29da891543f22e262d28cd1991106b205e909325',
     x86_64: 'eff47096581ed7982f4d3d4def1b79d3a7b6652772f039b45b26a5421adf2f62'
  })

  depends_on 'libmypaint'

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
