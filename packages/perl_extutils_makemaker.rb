require 'buildsystems/perl'

class Perl_extutils_makemaker < PERL
  description 'Create a module Makefile'
  homepage 'https://metacpan.org/pod/ExtUtils::MakeMaker'
  version '7.70-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/B/BI/BINGOS/ExtUtils-MakeMaker-7.70.tar.gz'
  source_sha256 'f108bd46420d2f00d242825f865b0f68851084924924f92261d684c49e3e7a74'
  binary_compression 'tar.zst'

  no_compile_needed

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
