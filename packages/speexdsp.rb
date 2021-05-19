require 'package'

class Speexdsp < Package
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2-095f'
  license 'BSD'
  compatibility 'all'
  source_url 'https://gitlab.xiph.org/xiph/speexdsp.git'
  git_hashtag '095fd36e189554bbcbfd9884630a53d7792409dc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speexdsp/1.2-095f_armv7l/speexdsp-1.2-095f-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speexdsp/1.2-095f_armv7l/speexdsp-1.2-095f-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speexdsp/1.2-095f_i686/speexdsp-1.2-095f-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speexdsp/1.2-095f_x86_64/speexdsp-1.2-095f-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fe34514fd4960fd4fe424a054329a56b6c502d85453b679a149129fd57b39cce',
     armv7l: 'fe34514fd4960fd4fe424a054329a56b6c502d85453b679a149129fd57b39cce',
       i686: 'd88d59b9f0165918fb0d6f34218209fa9ed3617c5ca5b5a70c3227ecfa328bb7',
     x86_64: '037c5fbb5c957ef1de46fed752894aec4edb08994343bc88ca1c40584b72e53f'
  })

  depends_on 'speex'

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
