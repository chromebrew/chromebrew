require 'package'

class Libmd < Package
  description 'libmd provides message digest functions found on BSD systems.'
  homepage 'https://www.hadrons.org/software/libmd/'
  version '1.0.4'
  license 'BSD-3, BSD-2, ISC, Beerware, public-domain'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libmd.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'd7f7fb355eeffac5bed6e547812810e56b722663262e8059048e3e66da1610b4',
     armv7l: 'd7f7fb355eeffac5bed6e547812810e56b722663262e8059048e3e66da1610b4',
       i686: 'd07ff3785775f604b95d0bfec9e3fefe054dc8b9131da983c93033ae4b5042c1',
     x86_64: '672b5ccf0a9b2188476b6c00940f93c2f8615c55694871e399076a6b7527cdba'
  })

  def self.build
    system 'autoupdate'
    system 'autoreconf -fiv'
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
