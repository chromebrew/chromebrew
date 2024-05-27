require 'package'

class Jasper < Package
  description 'The JasPer Project is an open-source initiative to provide a free software-based reference implementation of the codec specified in the JPEG-2000 Part-1 standard (i.e., ISO/IEC 15444-1).'
  homepage 'https://www.ece.uvic.ca/~frodo/jasper/'
  version '3.0.6'
  license 'JasPer-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/jasper-software/jasper.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7869ef04d5dab7ba48e2c240fa04cb74ea7a2408e0d33a5330ba65b606d519f7',
     armv7l: '7869ef04d5dab7ba48e2c240fa04cb74ea7a2408e0d33a5330ba65b606d519f7',
     x86_64: 'f7037e21cbcabd82eca2c8382fff9af133db731de5e31b8739eddae727fbfa89'
  })

  depends_on 'freeglut'
  depends_on 'libglu'
  depends_on 'libjpeg_turbo'
  depends_on 'mesa'
  depends_on 'shared_mime_info'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libheif' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DJAS_ENABLE_DOC=FALSE \
        -DBUILD_SHARED_LIBS=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
