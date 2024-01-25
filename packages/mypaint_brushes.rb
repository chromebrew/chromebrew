require 'package'

class Mypaint_brushes < Package
  description 'Brushes used by MyPaint and other software using libmypaint.'
  homepage 'http://mypaint.org/'
  version '2.0.2'
  license 'CC0-1.0'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint-brushes.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

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
