require 'package'

class Perl < Package
  version '5.16.3'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/qwbwhvqed0yyv3l/perl-5.16.3-chromeos-i686.tar.gz?token_hash=AAHjq1OrZ3iNYerA9y6QIPtsn3fOnW5QeIFbYlBbBN-OkA&dl=1'
  })
  binary_sha1 ({
    i686: 'e2a8c5280b8a4abec70256f41d5e5b04253d6796'
  })
end
