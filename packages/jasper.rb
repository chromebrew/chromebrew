require 'package'

class Jasper < Package
  description 'The JasPer Project is an open-source initiative to provide a free software-based reference implementation of the codec specified in the JPEG-2000 Part-1 standard (i.e., ISO/IEC 15444-1).'
  homepage 'https://www.ece.uvic.ca/~frodo/jasper/'
  version '3.0.6'
  license 'JasPer-2.0'
  compatibility 'all'
  source_url 'https://github.com/jasper-software/jasper.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jasper/3.0.6_armv7l/jasper-3.0.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jasper/3.0.6_armv7l/jasper-3.0.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jasper/3.0.6_i686/jasper-3.0.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jasper/3.0.6_x86_64/jasper-3.0.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7869ef04d5dab7ba48e2c240fa04cb74ea7a2408e0d33a5330ba65b606d519f7',
     armv7l: '7869ef04d5dab7ba48e2c240fa04cb74ea7a2408e0d33a5330ba65b606d519f7',
       i686: '99b928de2e3b4132d8c5a28dc80fd10db79fe32d3710a013e2b504238b39a10a',
     x86_64: 'f7037e21cbcabd82eca2c8382fff9af133db731de5e31b8739eddae727fbfa89'
  })

  depends_on 'freeglut'
  depends_on 'libglu'
  depends_on 'libjpeg'
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
