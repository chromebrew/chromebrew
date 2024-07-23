require 'buildsystems/perl'

class Perl_unicode_linebreak < PERL
  description 'Unicode::LineBreak - UAX #14 Unicode Line Breaking Algorithm'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2019.001-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak.git'
  git_hashtag 'Unicode-LineBreak-2019.001'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fdf8c7390909aec3bcf6eaa70ef7eb296f6d6b9cb51069b13f0f013acf14bbee',
     armv7l: 'fdf8c7390909aec3bcf6eaa70ef7eb296f6d6b9cb51069b13f0f013acf14bbee',
       i686: '27f9c39349b021df1119e03f013120afa4c768731d5cc1031094466ac1f951a3',
     x86_64: '3ee61ff64b06949c68645a06aaceb348e060b4ff7c5a371760789c3079a7b330'
  })

  depends_on 'glibc' # R
end
