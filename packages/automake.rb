require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  version '1.16.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/automake/automake-1.16.5.tar.xz'
  source_sha256 'f01d58cd6d9d77fbdca9eb4bbd5ead1988228fdb73d6f7a201f5f8d6b118b469'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'b991366b2b59e1c6bdbce17789552240019d7e4d175661dacf3533a66e584037',
     armv7l: 'b991366b2b59e1c6bdbce17789552240019d7e4d175661dacf3533a66e584037',
       i686: '08227a2c5b0151e3b854577c292647472b3c961659b66a5ba7652c2cdffd8be2',
     x86_64: '110762775901383e1f8eee7cd7cd621afdf0c1a417a903ca01f27db6274d01ff'
  })

  depends_on 'autoconf'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
