require 'package'

class Perl_unicode_linebreak < Package
  description 'Unicode::LineBreak - UAX #14 Unicode Line Breaking Algorithm'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2019.001-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak.git'
  git_hashtag 'Unicode-LineBreak-2019.001'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-2_armv7l/perl_unicode_linebreak-2019.001-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-2_armv7l/perl_unicode_linebreak-2019.001-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-2_i686/perl_unicode_linebreak-2019.001-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-2_x86_64/perl_unicode_linebreak-2019.001-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1f71d4967b901d3963686dc939a741fdb400097c09df8dc549a6cd41b6517843',
     armv7l: '1f71d4967b901d3963686dc939a741fdb400097c09df8dc549a6cd41b6517843',
       i686: '88fd6c7ba13998040d725c83befef32e63e6047c22a93dba099fdaaa2864e463',
     x86_64: '7cee8353db2d0da6fc91915f6be07e77fe4746f3ab60e0e145c46cdf52150b75'
  })

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
