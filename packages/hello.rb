require 'package'

class Hello < Package
  description 'GNU Hello is another implementation of the classic program that prints “Hello, world!”'
  homepage 'https://www.gnu.org/software/hello/'
  version '2.12'
  license 'FDL-1.3 GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/hello/hello-2.12.tar.gz'
  source_sha256 'cf04af86dc085268c5f4470fbae49b18afbc221b78096aab842d934a76bad0ab'

  binary_url({
     aarch64: 'file:///usr/local/tmp/packages/hello-2.12-chromeos-armv7l.tar.zst',
      armv7l: 'file:///usr/local/tmp/packages/hello-2.12-chromeos-armv7l.tar.zst',
        i686: 'file:///usr/local/tmp/packages/hello-2.12-chromeos-i686.tar.zst',
      x86_64: 'file:///usr/local/tmp/packages/hello-2.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
     aarch64: 'd079ff23c790871d483da8894a9c08ec926b11ea794b1752196505f24c4e414f',
      armv7l: 'd079ff23c790871d483da8894a9c08ec926b11ea794b1752196505f24c4e414f',
        i686: '7b204599aff88629368f464a685a5122d814ab1a2577b33147d9aefd2567c1f7',
      x86_64: 'a527974c8ffb25107cffe7790a2561e299a24ebcd0d491bc0f0d981e073559f8'
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
