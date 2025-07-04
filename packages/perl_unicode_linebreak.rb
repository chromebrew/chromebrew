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
    aarch64: '9aef5868ff1ca6fdd3b0c3a9f8371efe2250a67a4c7ea991bc1a010039f1c887',
     armv7l: '9aef5868ff1ca6fdd3b0c3a9f8371efe2250a67a4c7ea991bc1a010039f1c887',
       i686: 'e7d077c763d49aa3605f2e4025adf8acf3268c640b709c9e9314b8dbc8b76287',
     x86_64: 'f5d2e4044eb9b5e7a4f375aabe74c08bc5d10e13a6dac4e44f2633703919ac63'
  })

  depends_on 'glibc' # R
end
