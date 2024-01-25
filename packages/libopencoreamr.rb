require 'package'

class Libopencoreamr < Package
  description 'Audio codecs extracted from Android Open Source Project.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '0.1.5-0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.5.tar.gz'
  source_sha256 '2c006cb9d5f651bfb5e60156dbff6af3c9d35c7bbcc9015308c0aff1e14cd341'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '637a39ca077305a37b9a7e58e46d4344f29d5ce1e1ab6febd7d93d6727ef88bd',
     armv7l: '637a39ca077305a37b9a7e58e46d4344f29d5ce1e1ab6febd7d93d6727ef88bd',
       i686: '75b3d8849bac7849ab4ea916ec94e5d05870becf98bc29d007a18fdf58ea732a',
     x86_64: '22c116cc561c16012f909768f1794d27b72335573c1ac97a67d4463693be492a'
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
