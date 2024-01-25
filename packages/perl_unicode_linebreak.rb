require 'buildsystems/perl'

class Perl_unicode_linebreak < PERL
  description 'Unicode::LineBreak - UAX #14 Unicode Line Breaking Algorithm'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2019.001-perl5.38.2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak.git'
  git_hashtag 'Unicode-LineBreak-2019.001'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38.2_armv7l/perl_unicode_linebreak-2019.001-perl5.38.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38.2_armv7l/perl_unicode_linebreak-2019.001-perl5.38.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38.2_i686/perl_unicode_linebreak-2019.001-perl5.38.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38.2_x86_64/perl_unicode_linebreak-2019.001-perl5.38.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'db3f602563a48c48a482e4199a0eb14a033e28951f8b99ea25a6274cd4de93ee',
     armv7l: 'db3f602563a48c48a482e4199a0eb14a033e28951f8b99ea25a6274cd4de93ee',
       i686: '1ef1312e2ec8643322515daaaab94324630f81266f02970dd2b8ba51db9e4611',
     x86_64: '78be2dc27f3779fc4dffdc529d8fb9b7962ea594b3aadefbe88f50cc4bf32c32'
  })

  depends_on 'glibc' # R
end
