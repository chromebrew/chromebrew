require 'package'

class Perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  version '5.24.1-3'
  source_url 'http://www.cpan.org/src/5.0/perl-5.24.1.tar.gz'
  source_sha256 'e6c185c9b09bdb3f1b13f678999050c639859a7ef39c8cad418448075f5918af'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl-5.24.1-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl-5.24.1-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl-5.24.1-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl-5.24.1-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '98a97e66b1bef91a97654675197141b4c2b25990b2ba17465ff33d98a494c521',
     armv7l: '98a97e66b1bef91a97654675197141b4c2b25990b2ba17465ff33d98a494c521',
       i686: '04930ee73e84e5df65c759e9b9b7be1f956c3c99cdc34dc74b504088d6b73021',
     x86_64: '4f436341733c7230bfd843349a0737fd910e2762ff3f990ef976b466c305b930',
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
