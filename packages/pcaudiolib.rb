require 'package'

class Pcaudiolib < Package
  description 'PCaudiolib is a portable C audio library.'
  homepage 'https://github.com/espeak-ng/pcaudiolib'
  version '1.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/espeak-ng/pcaudiolib/archive/refs/tags/1.1.tar.gz'
  source_sha256 '699a5a347b1e12dc5b122e192e19f4db01621826bf41b9ebefb1cbc63ae2180b'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcaudiolib/1.1_armv7l/pcaudiolib-1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcaudiolib/1.1_armv7l/pcaudiolib-1.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcaudiolib/1.1_i686/pcaudiolib-1.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcaudiolib/1.1_x86_64/pcaudiolib-1.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'deefd29e6e3d4505e95ab0d31a6c076c36030486e0e238ea9c59f64ef9575357',
     armv7l: 'deefd29e6e3d4505e95ab0d31a6c076c36030486e0e238ea9c59f64ef9575357',
       i686: '1ffe549630aa80535d060a17c3924491954838980556ce05771f2e9c68ba16e0',
     x86_64: '65bbcac0a42d5048d8e55cd8dae0dce345da31280d50a979ec9eb4432ac43758'
  })

  depends_on 'alsa_lib'

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-O2 -pipe -flto=auto -fuse-ld=gold' \
                LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS} \
              --without-pulseaudio \
              --with-alsa \
              --without-qsa \
              --without-coreaudio \
              --without-oss"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
