require 'package'

class Libsndfile < Package
  description 'Libsndfile is a C library for reading and writing files containing sampled sound (such as MS Windows WAV and the Apple/SGI AIFF format) through one standard library interface.'
  homepage 'http://www.mega-nerd.com/libsndfile/'
  version '1.0.28-1'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz'
  source_sha256 '1ff33929f042fa333aed1e8923aa628c3ee9e1eb85512686c55092d1e5a9dfa9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsndfile/1.0.28-1_armv7l/libsndfile-1.0.28-1-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsndfile/1.0.28-1_armv7l/libsndfile-1.0.28-1-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsndfile/1.0.28-1_i686/libsndfile-1.0.28-1-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsndfile/1.0.28-1_x86_64/libsndfile-1.0.28-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b279c7ec6a4fd1707d48a9be62bdcc236a3a539233664e50c5940c4d881f56dc',
      armv7l: 'b279c7ec6a4fd1707d48a9be62bdcc236a3a539233664e50c5940c4d881f56dc',
        i686: 'e86f9c4a983449b36eec818fd0c96ebe42d509d235c9636fcf7373288eff4730',
      x86_64: 'e3beeeee584a67e385f249987254b07f3f7239d9c4bce4a9c1070b3095b171e9'
  })

  depends_on 'libvorbis'
  depends_on 'speex'
  depends_on 'libogg'
  depends_on 'opus'
  depends_on 'flac'
  depends_on 'sqlite' => :build
  depends_on 'alsa_lib' => :build
  depends_on 'nasm' => :build

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
