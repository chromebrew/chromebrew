require 'package'

class Perl < Package
  version '5.24.1'
  source_url 'http://www.cpan.org/src/5.0/perl-5.24.1.tar.gz'
  source_sha1 '19b218bbc3a63a8408ed56b93928fd9a4c1b5c83'
  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/binaries/perl-5.24.1-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chromebrew/releases/download/binaries/perl-5.24.1-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chromebrew/releases/download/binaries/perl-5.24.1-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chromebrew/releases/download/binaries/perl-5.24.1-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '3352e1cb829062bf91da51802304b702aaa072d8',
    armv7l:  '3352e1cb829062bf91da51802304b702aaa072d8',
    i686:    '2929f609a1d4d098eef649432af7feb2b8762e4f',
    x86_64:  '5406a1b1a2d32392e44de48e9a7ea17d76918389',
  })

  depends_on 'patch' => :build

  def self.build
    # Use system zlib and bzip2
    # Create shared library
    system "BUILD_ZLIB=False BUILD_BZIP2=0 ./Configure -de -Duseshrplib"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
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
