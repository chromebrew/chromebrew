require 'package'

class Speex < Package
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2-870f'
  license 'BSD'
  compatibility 'all'
  source_url 'https://gitlab.xiph.org/xiph/speex.git'
  git_hashtag '870ff845b32f314aec0036641ffe18aba4916887'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2-870f_armv7l/speex-1.2-870f-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2-870f_armv7l/speex-1.2-870f-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2-870f_i686/speex-1.2-870f-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2-870f_x86_64/speex-1.2-870f-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1f4901f04da81fe723e0c0181ad1ec5066c138c4ecb7f8854983e986108914be',
     armv7l: '1f4901f04da81fe723e0c0181ad1ec5066c138c4ecb7f8854983e986108914be',
       i686: 'e69fcd81e05805c964067e130961e9467add67ec50a850b2837ba6df705e6712',
     x86_64: 'e448b7e79abf3a303d54d3997a9f491b086c55f7c5ae8b3654f61cfb636fd917'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-dependency-tracking \
      --disable-maintainer-mode \
      --disable-examples"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
