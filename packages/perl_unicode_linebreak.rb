require 'buildsystems/perl'

class Perl_unicode_linebreak < PERL
  description 'Unicode::LineBreak - UAX #14 Unicode Line Breaking Algorithm'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version "2019.001-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak.git'
  git_hashtag 'Unicode-LineBreak-2019.001'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7a53fe75b32fe7fa32fc4dd37e2212f4f9edf452b2eda6baf6f1b366c8ce30d',
     armv7l: 'f7a53fe75b32fe7fa32fc4dd37e2212f4f9edf452b2eda6baf6f1b366c8ce30d',
       i686: 'b980da46a31246a8ecb23f28e57836443bf4cbcc0cd0e26a72a95adc956227b6',
     x86_64: 'f053789039ce33f1cd0751bc028ea035bb2275649cdc46418fe1d4289f769e09'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
end
