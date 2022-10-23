require 'package'

class Hello < Package
  description 'GNU Hello is another implementation of the classic program that prints “Hello, world!”'
  homepage 'https://www.gnu.org/software/hello/'
  version '2.12'
  license 'FDL-1.3 GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/hello/hello-2.12.tar.gz'
  source_sha256 'cf04af86dc085268c5f4470fbae49b18afbc221b78096aab842d934a76bad0ab'

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
