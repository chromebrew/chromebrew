require 'buildsystems/perl'

class Perl_extutils_makemaker < PERL
  description 'Create a module Makefile'
  homepage 'https://metacpan.org/pod/ExtUtils::MakeMaker'
  version "7.70-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/B/BI/BINGOS/ExtUtils-MakeMaker-7.70.tar.gz'
  source_sha256 'f108bd46420d2f00d242825f865b0f68851084924924f92261d684c49e3e7a74'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f040ddc442bda8b7d18bb7484f46943e5f20dcae440491b30ab0614fc1d2342',
     armv7l: '5f040ddc442bda8b7d18bb7484f46943e5f20dcae440491b30ab0614fc1d2342',
       i686: 'a428c4dca0a4300d4fa13d1a929c34c103b37dc43be5309666e2a42da173ab32',
     x86_64: 'e0cffbbd4124a87cadddec22b574cd6bfee55d1da1ae384777d94dc77966bce4'
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
