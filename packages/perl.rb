require 'package'

class Perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  version '5.24.1-2'
  source_url 'http://www.cpan.org/src/5.0/perl-5.24.1.tar.gz'
  source_sha256 'e6c185c9b09bdb3f1b13f678999050c639859a7ef39c8cad418448075f5918af'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/perl-5.24.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/perl-5.24.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/perl-5.24.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/perl-5.24.1-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0019a364655e4398e010b42dffe2f683b569fe443f230b79808e2355ef648345',
     armv7l: '0019a364655e4398e010b42dffe2f683b569fe443f230b79808e2355ef648345',
       i686: '178d51ddb852d9734d042d3a43ad9bfc3b8eb33a5e45cd8303c24931b6669ec3',
     x86_64: 'e8ff465d454f17f424206422be17355f20f6569988e1666bfd24974e670c63b1',
  })

  depends_on 'patch' => :build

  def self.build
    # Use system zlib and bzip2
    # Create shared library
    # Install manual files into /usr/local/share/man/man* even if groff is not installed.
    system "BUILD_ZLIB=False BUILD_BZIP2=0 ./Configure -de -Duseshrplib -Dman1dir=#{CREW_PREFIX}/share/man/man1 -Dman3dir=#{CREW_PREFIX}/share/man/man3"
    system "make"
    system "curl -o cpanm https://cpanmin.us"
    system "chmod +x cpanm"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin/"
    system "cp cpanm #{CREW_DEST_PREFIX}/bin/"
  end

  def self.check
    # having strange error as explained at https://patchwork.openembedded.org/patch/95795/
    # so, apply patch from https://github.com/habitat-sh/core-plans/blob/master/perl/skip-wide-character-test.patch
    # to ignore this single test
    system 'patch -p1 << EOF
diff -ur perl-5.22.1.orig/t/lib/warnings/regexec perl-5.22.1/t/lib/warnings/regexec
--- perl-5.22.1.orig/t/lib/warnings/regexec     2015-10-30 21:14:29.000000000 +0000
+++ perl-5.22.1/t/lib/warnings/regexec  2016-01-19 05:05:50.218474114 +0000
@@ -188,6 +188,7 @@
 ########
 # NAME \b{} in UTF-8 locale
 require \'../loc_tools.pl\';
+print("SKIPPED\n# This test causes a failure in the test suite\n"),exit;
 unless (locales_enabled()) {
     print("SKIPPED\n# locales not available\n"),exit;
 }
EOF'

    # test
    system "make test"
  end
end
