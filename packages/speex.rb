require 'package'

class Speex < Package
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2rc3-1'
  license 'BSD'
  compatibility 'all'
  source_url 'http://downloads.xiph.org/releases/speex/speexdsp-1.2rc3.tar.gz'
  source_sha256 '4ae688600039f5d224bdf2e222d2fbde65608447e4c2f681585e4dca6df692f1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2rc3-1_armv7l/speex-1.2rc3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2rc3-1_armv7l/speex-1.2rc3-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speexdsp/1.2rc3_i686/speexdsp-1.2rc3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2rc3-1_x86_64/speex-1.2rc3-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7583ec635edf411815b3ec3b03941559180d41cb7f1e375ee9d43bb720fc47bb',
     armv7l: '7583ec635edf411815b3ec3b03941559180d41cb7f1e375ee9d43bb720fc47bb',
       i686: '5c3d9bd633a11a8da1e8408d6db745f620d759ea2e4f8239a9ab5b34a9fe6b6a',
     x86_64: '209375ce4d5f48d6449ddb876f3bf94f4f562979a3937ef81fbedffddc7d3898'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
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
