require 'package'

class Perl_unicode_eastasianwidth < Package
  description 'Perl Unicode::EastAsianWidth - East Asian Width properties.'
  homepage 'https://metacpan.org/pod/Unicode::EastAsianWidth'
  version '1.33'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Unicode-EastAsianWidth-1.33.tar.gz'
  source_sha256 '41c9f0b50c45dd806a97de73f9fe93516b6c63255e2a5174e5fb2d89635c7797'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_unicode_eastasianwidth-1.33-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_unicode_eastasianwidth-1.33-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_unicode_eastasianwidth-1.33-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_unicode_eastasianwidth-1.33-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a307d2bfb7805a345ed47069aa51db0f509f7887f034e972c2125f1ce7781617',
     armv7l: 'a307d2bfb7805a345ed47069aa51db0f509f7887f034e972c2125f1ce7781617',
       i686: '738bd0a51ae004d7d1fc03cb9d73d1a3fd7674f40f4b0fc049749a313e1b3cac',
     x86_64: 'ca7516e05ea52ad7c988209ee0fdce1aebf32434eb2ba7f6fc03015588088a6f',
  })

  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', "build", '--self-contained', '.'

    # install lib
    libdir = `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    system "mkdir -p #{CREW_DEST_DIR}#{libdir}"
    system "(cd build/lib/perl5; tar cf - .) | (cd #{CREW_DEST_DIR}#{libdir}; tar xfp -)"

    # install man
    mandir = "#{CREW_PREFIX}/share/man"
    system "mkdir -p #{CREW_DEST_DIR}#{mandir}"
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_DIR}#{mandir}; tar xfp -)"
  end

  def self.check
  end
end
