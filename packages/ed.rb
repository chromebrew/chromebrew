require 'package'

class Ed < Package
  description 'GNU ed is a line-oriented text editor.'
  homepage 'http://www.gnu.org/software/ed/ed.html'
  version '1.15'
  source_url 'https://ftpmirror.gnu.org/ed/ed-1.15.tar.lz'
  source_sha256 'ad4489c0ad7a108c514262da28e6c2a426946fb408a3977ef1ed34308bdfd174'

  binary_url ({
  })
  binary_sha256 ({
  })

  # only lz archive is available for ed and it requires lzip.
  depends_on 'lzip' => :build

  def self.build
    system "./configure",
	   "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
