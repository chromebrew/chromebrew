require 'package'

class Pcaudiolib < Package
  description 'PCaudiolib is a portable C audio library.'
  homepage 'https://github.com/espeak-ng/pcaudiolib'
  version '1.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/espeak-ng/pcaudiolib/archive/refs/tags/1.1.tar.gz'
  source_sha256 '699a5a347b1e12dc5b122e192e19f4db01621826bf41b9ebefb1cbc63ae2180b'

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
