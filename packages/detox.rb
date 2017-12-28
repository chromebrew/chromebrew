require 'package'

class Detox < Package
  description 'Detox is a utility designed to clean up filenames. It replaces non-standard characters, such as spaces, with standard equivalents.'
  homepage 'https://sourceforge.net/projects/detox/'
  version '1.2.0'
  source_url 'https://downloads.sourceforge.net/project/detox/detox/1.2.0/detox-1.2.0.tar.bz2'
  source_sha256 'abfad90ee7d3e0fc53ce3b9da3253f9a800cdd92e3f8cc12a19394a7b1dcdbf8'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'flex'
  depends_on 'popt'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--with-popt=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
