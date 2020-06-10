require 'package'

class Colordiff < Package
  description "The Perl script colordiff is a wrapper for 'diff' and produces the same output but with pretty 'syntax' highlighting."
  homepage 'https://www.colordiff.org/'
  version '1.0.18'
  compatibility 'all'
  source_url 'https://www.colordiff.org/colordiff-1.0.18.tar.gz'
  source_sha256 '29cfecd8854d6e19c96182ee13706b84622d7b256077df19fbd6a5452c30d6e0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/colordiff-1.0.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/colordiff-1.0.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/colordiff-1.0.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/colordiff-1.0.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f8e3848078a822375729d5243697ed856e45db41badef0db95052dac3beac452',
     armv7l: 'f8e3848078a822375729d5243697ed856e45db41badef0db95052dac3beac452',
       i686: 'f47a74e3d39e7b72989925434897313ca1a98c11e6895c30c1db7f23049ac166',
     x86_64: 'd0cafc057a6967a0232ec57769a9b013e1e4cc8412b3b0ece257cc622f2a3234',
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
