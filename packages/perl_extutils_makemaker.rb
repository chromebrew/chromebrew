require 'buildsystems/perl'

class Perl_extutils_makemaker < PERL
  description 'Create a module Makefile'
  homepage 'https://metacpan.org/pod/ExtUtils::MakeMaker'
  version "7.78-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/B/BI/BINGOS/ExtUtils-MakeMaker-#{version.split('-')[0]}.tar.gz"
  source_sha256 'f108bd46420d2f00d242825f865b0f68851084924924f92261d684c49e3e7a74'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c5c2cf124665713a59bb936c0c1f53117d1c4d25e6b38fc5183df8d2fedc60e',
     armv7l: '6c5c2cf124665713a59bb936c0c1f53117d1c4d25e6b38fc5183df8d2fedc60e',
       i686: '465c902b8c01e24957510a6732900d76183b87449843afbde5e085186119a739',
     x86_64: '6833b2f5ce0e5e6915db320574dee887a334597d6f7c8fa259e7e6c53040a842'
  })

  depends_on 'perl' => :logical

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
