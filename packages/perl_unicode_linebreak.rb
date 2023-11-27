require 'buildsystems/perl'

class Perl_unicode_linebreak < PErl
  description 'Unicode::LineBreak - UAX #14 Unicode Line Breaking Algorithm'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2019.001-perl5.38.1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak.git'
  git_hashtag 'Unicode-LineBreak-2019.001'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38.1_armv7l/perl_unicode_linebreak-2019.001-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38.1_armv7l/perl_unicode_linebreak-2019.001-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38.1_i686/perl_unicode_linebreak-2019.001-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38.1_x86_64/perl_unicode_linebreak-2019.001-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4bc38ca83a5bdbe1bf9fd3f10c0887258268a69f0710a5a2d6218fb70d1d0162',
     armv7l: '4bc38ca83a5bdbe1bf9fd3f10c0887258268a69f0710a5a2d6218fb70d1d0162',
       i686: 'd82010b278d16f60edc9f7910c04c5f76061bf455072be2ddb9dd29af68517b4',
     x86_64: '7522a12b304edb4a949b5a258b6f466341a424f73e39c84b8c4195eb7e03dfa9'
  })

  depends_on 'glibc' # R
end
