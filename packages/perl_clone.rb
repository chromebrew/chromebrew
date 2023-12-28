require 'buildsystems/perl'

class Perl_clone < PERL
  description 'Recursively copy Perl datatypes'
  homepage 'https://metacpan.org/pod/Clone'
  version '0.46-perl5.38.1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GA/GARU/Clone-0.46.tar.gz'
  source_sha256 'aadeed5e4c8bd6bbdf68c0dd0066cb513e16ab9e5b4382dc4a0aafd55890697b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38.1_armv7l/perl_clone-0.46-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38.1_armv7l/perl_clone-0.46-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38.1_i686/perl_clone-0.46-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38.1_x86_64/perl_clone-0.46-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '858e50ef6af0a990dd1d525859944ab2c6a1f0b872cf5a3f24e931bbc7eda7b5',
     armv7l: '858e50ef6af0a990dd1d525859944ab2c6a1f0b872cf5a3f24e931bbc7eda7b5',
       i686: 'ee24c41eb288ee594fa24e67bb6be8240eb44a877e03eb91ce89ad3b5a567be8',
     x86_64: '13673871d5f15a9d165f2bdc4e234c263291f6f6efbed201e50f2db37628b53f'
  })

  depends_on 'glibc' # R
end
