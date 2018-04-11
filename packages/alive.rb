require 'package'

class Alive < Package
  description 'Automatic login and keep-alive utility for Internet connections.'
  homepage 'https://www.gnu.org/software/alive/'
  version '2.0.2'
  source_url 'https://ftpmirror.gnu.org/alive/alive-2.0.2.tar.xz'
  source_sha256 '120dd9ef361833623be353ad8cfac585abae51a16fedd3a84f1d99a842793fef'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'guile'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
