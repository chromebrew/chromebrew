require 'package'

class Dash < Package
  description 'The Debian Almquist Shell (dash) is a POSIX-compliant shell derived from ash that executes scripts faster than bash and has fewer library dependencies.'
  homepage 'https://salsa.debian.org/debian/dash/'
  version '0.5.11.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/dash.git'
  git_hashtag 'upstream/0.5.11.2'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '1b44e3da6bfc8c4e10752b14da464d8a04b748025de69423f944fac8035dbb96',
     armv7l: '1b44e3da6bfc8c4e10752b14da464d8a04b748025de69423f944fac8035dbb96',
       i686: 'ac582d141f234881f09860bc400688b0462d92431a5ef739c59687e09cdb9299',
     x86_64: 'fc193b1d169b2341cd99e329552740656706ae3e22867733eac7d2f7873053b8'
  })

  depends_on 'libedit'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-libedit"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
