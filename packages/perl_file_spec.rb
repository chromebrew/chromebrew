require 'buildsystems/perl'

class Perl_file_spec < PERL
  description 'Portably perform operations on file names'
  homepage 'https://metacpan.org/pod/File::Spec'
  version "3.75-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XS/XSAWYERX/PathTools-3.75.tar.gz'
  source_sha256 'a558503aa6b1f8c727c0073339081a77888606aa701ada1ad62dd9d8c3f945a2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d530cfc20c1086d2130ba39bc8b190bff44147e60c1cf5d9e640903b793ed4f',
     armv7l: '0d530cfc20c1086d2130ba39bc8b190bff44147e60c1cf5d9e640903b793ed4f',
       i686: 'b29479b3ad1082eb506fc48ed9b90d89c87ec02333816bfab3c5f536847bea9a',
     x86_64: 'fb13283d8ab33ce4b1d1c1b0832500c1756bab618bdadd7869bae58bb15cf818'
  })

  depends_on 'glibc' # R

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @perl_conflicts = %w[
      Cwd
      File::Spec
      File::Spec::AmigaOS
      File::Spec::Cygwin
      File::Spec::Epoc
      File::Spec::Functions
      File::Spec::Mac
      File::Spec::OS2
      File::Spec::Unix
      File::Spec::VMS
      File::Spec::Win32
    ]
    @perl_conflicts.each do |conflict|
      if File.exist?("#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3")
        FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3",
                     "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
      end
    end
  end
end
