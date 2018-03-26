require 'package'

class Colordiff < Package
  description "The Perl script colordiff is a wrapper for 'diff' and produces the same output but with pretty 'syntax' highlighting."
  homepage 'https://www.colordiff.org/'
  version '1.0.18'
  source_url 'https://www.colordiff.org/colordiff-1.0.18.tar.gz'
  source_sha256 '29cfecd8854d6e19c96182ee13706b84622d7b256077df19fbd6a5452c30d6e0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'perl'

  def self.install
    system "sed -i 's,/etc,#{CREW_PREFIX}/etc,g' colordiff.pl"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' colordiff.pl"
    system "install -Dm755 colordiff.pl #{CREW_DEST_PREFIX}/bin/colordiff"
    system "install -Dm755 cdiff.sh #{CREW_DEST_PREFIX}/bin/cdiff"
    system "gzip -9 cdiff.1 colordiff.1"
    system "install -Dm644 cdiff.1.gz #{CREW_DEST_PREFIX}/man/man1/cdiff.1.gz"
    system "install -Dm644 colordiff.1.gz #{CREW_DEST_PREFIX}/man/man1/colordiff.1.gz"
    system "install -Dm644 colordiffrc #{CREW_DEST_PREFIX}/etc/colordiffrc"
    system "mkdir -p #{CREW_DEST_DIR}/$HOME"
    system "ln -s #{CREW_PREFIX}/etc/colordiffrc #{CREW_DEST_DIR}/$HOME/.colordiffrc"
    system "ln -sf #{CREW_PREFIX}/etc/colordiffrc $HOME/.colordiffrc"
  end
end
