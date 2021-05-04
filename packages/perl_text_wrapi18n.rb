require 'package'

class Perl_text_wrapi18n < Package
  description 'Text::WrapI18N - Line wrapping module with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words.'
  homepage 'https://metacpan.org/pod/Text::WrapI18N'
  version '0.06-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-WrapI18N-0.06.tar.gz'
  source_sha256 '4bd29a17f0c2c792d12c1005b3c276f2ab0fae39c00859ae1741d7941846a488'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-2_armv7l/perl_text_wrapi18n-0.06-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-2_armv7l/perl_text_wrapi18n-0.06-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-2_i686/perl_text_wrapi18n-0.06-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-2_x86_64/perl_text_wrapi18n-0.06-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'baad1da36dc023de04364df3ee4f799d71cc7b6210016737b23e0d1015899159',
     armv7l: 'baad1da36dc023de04364df3ee4f799d71cc7b6210016737b23e0d1015899159',
       i686: 'f23dc5661e9721815a4504e57f82ac0c12513b830b31983d0454e628911cdd71',
     x86_64: '3abbedc8db8e87eb086dafba589ebeda760ff2c16d9f97698e09dc15f1fdc309'
  })

  depends_on 'perl_text_charwidth'

  def self.build; end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '.' #  remove --self-contained

    # install lib
    libdir = CREW_DEST_DIR + `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    FileUtils.mkdir_p libdir
    system "(cd build/lib/perl5; tar cf - .) | (cd #{libdir}; tar xfp -)"

    # install man
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_MAN_PREFIX}; tar xfp -)"
  end

  def self.check; end
end
