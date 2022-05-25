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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hello/2.12_armv7l/hello-2.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hello/2.12_armv7l/hello-2.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hello/2.12_i686/hello-2.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hello/2.12_x86_64/hello-2.12-chromeos-x86_64.tar.zst'
  })
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
