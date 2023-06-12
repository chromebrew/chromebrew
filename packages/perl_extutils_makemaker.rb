require 'package'

class Perl_extutils_makemaker < Package
  description 'Create a module Makefile'
  homepage 'https://metacpan.org/pod/ExtUtils::MakeMaker'
  version '7.70-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/B/BI/BINGOS/ExtUtils-MakeMaker-7.70.tar.gz'
  source_sha256 'f108bd46420d2f00d242825f865b0f68851084924924f92261d684c49e3e7a74'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_makemaker/7.70-perl5.36_armv7l/perl_extutils_makemaker-7.70-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_makemaker/7.70-perl5.36_armv7l/perl_extutils_makemaker-7.70-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_makemaker/7.70-perl5.36_i686/perl_extutils_makemaker-7.70-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_makemaker/7.70-perl5.36_x86_64/perl_extutils_makemaker-7.70-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '60ce24dcf38163b91d06705de3b6dbf648c5ce95fbc5c92586ee6e73572ead27',
     armv7l: '60ce24dcf38163b91d06705de3b6dbf648c5ce95fbc5c92586ee6e73572ead27',
       i686: '8cbb1c4223271d4bd18b99fe9636f765cce0d4e1d198d9e38ed1da67792c1653',
     x86_64: 'f01bfae2b9bb137290079af71746fb6a0ee065156287d164b78a30404b626343'
  })

  no_compile_needed

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Remove conflicts with perl package.
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/instmodsh"
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man1/instmodsh.1"
    @perl_conflicts = %w[
      ExtUtils::Command
      ExtUtils::Command::MM
      ExtUtils::Liblist
      ExtUtils::MakeMaker ExtUtils::MakeMaker::Config
      ExtUtils::MakeMaker::FAQ
      ExtUtils::MakeMaker::Locale
      ExtUtils::MakeMaker::Tutorial
      ExtUtils::Mkbootstrap
      ExtUtils::Mksymlists
      ExtUtils::MM
      ExtUtils::MM_AIX
      ExtUtils::MM_Any
      ExtUtils::MM_BeOS
      ExtUtils::MM_Cygwin
      ExtUtils::MM_Darwin
      ExtUtils::MM_DOS
      ExtUtils::MM_MacOS
      ExtUtils::MM_NW5
      ExtUtils::MM_OS2
      ExtUtils::MM_OS390
      ExtUtils::MM_QNX
      ExtUtils::MM_Unix
      ExtUtils::MM_UWIN
      ExtUtils::MM_VMS
      ExtUtils::MM_VOS
      ExtUtils::MM_Win32
      ExtUtils::MM_Win95
      ExtUtils::MY
      ExtUtils::testlib
    ]
    @perl_conflicts.each do |conflict|
      if File.exist?("#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3")
        FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3",
                     "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
      end
    end
  end
end
