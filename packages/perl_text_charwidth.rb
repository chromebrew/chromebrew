require 'package'

class Perl_text_charwidth < Package
  description 'Text::CharWidth - Get number of occupied columns of a string on terminals'
  homepage 'https://metacpan.org/pod/Text::CharWidth'
  version '0.04-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-CharWidth-0.04.tar.gz'
  source_sha256 'abded5f4fdd9338e89fd2f1d8271c44989dae5bf50aece41b6179d8e230704f8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-2_armv7l/perl_text_charwidth-0.04-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-2_armv7l/perl_text_charwidth-0.04-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-2_i686/perl_text_charwidth-0.04-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-2_x86_64/perl_text_charwidth-0.04-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '965175c70ca4cc515bdf139a4668434b6dd02ab565ae5b84705b508af005028e',
     armv7l: '965175c70ca4cc515bdf139a4668434b6dd02ab565ae5b84705b508af005028e',
       i686: 'ca46530e55475d03663fc0d821ee20e02eedafc4fa32ded01d622cd1af35d621',
     x86_64: '38a4a507e655a9bbd3b4aeae1a49f32e9ef27b1a5ef2c5e7e9efef760f3e98ed'
  })

  def self.build; end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '.'

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
