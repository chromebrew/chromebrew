require 'package'

class Perl < Package
  version '5.24.1'
  source_url 'http://www.cpan.org/src/5.0/perl-5.24.1.tar.gz'
  source_sha1 '19b218bbc3a63a8408ed56b93928fd9a4c1b5c83'
  binary_url ({
    armv7l: 'https://github.com/jam7/chromebrew/releases/download/binaries/perl-5.24.1-chromeos-armv7l.tar.xz',
    i686:   'https://github.com/jam7/chromebrew/releases/download/binaries/perl-5.24.1-chromeos-i686.tar.xz',
    x86_64: 'https://github.com/jam7/chromebrew/releases/download/binaries/perl-5.24.1-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    armv7l: '3352e1cb829062bf91da51802304b702aaa072d8',
    i686:   '2929f609a1d4d098eef649432af7feb2b8762e4f',
    x86_64: '5406a1b1a2d32392e44de48e9a7ea17d76918389',
  })
end
