require 'package'

class Hello < Package
  description 'GNU Hello is another implementation of the classic program that prints “Hello, world!”'
  homepage 'https://www.gnu.org/software/hello/'
  version '2.12'
  license 'FDL-1.3 GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/hello/hello-2.12.tar.gz'
  source_sha256 'cf04af86dc085268c5f4470fbae49b18afbc221b78096aab842d934a76bad0ab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ffdc1749b56194ef9913c92d98aa29b2ed7592eb9c52828f0e458da9a84f977',
     armv7l: '1ffdc1749b56194ef9913c92d98aa29b2ed7592eb9c52828f0e458da9a84f977',
       i686: 'c75ebf55540a37f20fdcb80c4c0157d88ce8f269e16bf158fe35b41c37427a41',
     x86_64: '432d72ce76e2224d5af08ddaa323b577dd625cfac7feefe18866c9afdf3b1190'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
