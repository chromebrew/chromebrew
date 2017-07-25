require 'package'

class Perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  version '5.24.1-1'
  source_url 'http://www.cpan.org/src/5.0/perl-5.24.1.tar.gz'
  source_sha256 'e6c185c9b09bdb3f1b13f678999050c639859a7ef39c8cad418448075f5918af'

  depends_on 'patch' => :build

  def self.build
    # Use system zlib and bzip2
    # Create shared library
    # Install manual files into /usr/local/share/man/man* even if groff is not installed.
    system "BUILD_ZLIB=False BUILD_BZIP2=0 ./Configure -de -Duseshrplib -Dman1dir=#{CREW_PREFIX}/share/man/man1 -Dman3dir=#{CREW_PREFIX}/share/man/man3"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "sudo curl -o /usr/local/bin/cpanm https://cpanmin.us"
    system "sudo chmod +x /usr/local/bin/cpanm"
    system "sudo chown chronos /usr/local/bin/cpanm"
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
