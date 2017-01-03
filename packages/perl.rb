require 'package'

class Perl < Package
  version '5.16.3'
  binary_url ({
    armv7l: 'https://dl.dropboxusercontent.com/s/s1rae23cgzwaf7h/perl-5.16.3-chromeos-armv7l.tar.xz',
    i686: 'https://dl.dropboxusercontent.com/s/qwbwhvqed0yyv3l/perl-5.16.3-chromeos-i686.tar.gz?token_hash=AAHjq1OrZ3iNYerA9y6QIPtsn3fOnW5QeIFbYlBbBN-OkA&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/gg2q9tsvy2ybf80/perl-5.18.1-chromeos-x86_64.tar.gz?token_hash=AAFbAeYB604esg7FRBM_TeBh2hiDg2Bw8eZfPHFH8zCdHw&dl=1'
  })
  binary_sha1 ({
    armv7l: '1ae814842e24bbe4e6b3da5d13e1f7e8862957ba',
    i686: 'e2a8c5280b8a4abec70256f41d5e5b04253d6796',
    x86_64: '5bf7c1762499a40f2ce8684be6f5699c6a4658e1'
  })
end
