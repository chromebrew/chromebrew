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
    aarch64: 'cd7942b6a912309c2715bccfab06295671a31a9b8d46cfe0987a4c5d25beac27',
     armv7l: 'cd7942b6a912309c2715bccfab06295671a31a9b8d46cfe0987a4c5d25beac27',
       i686: '1abfd0778eeb57cfc88e297c93a45569e0929889d5dd1b1956307aebce3b1caf',
     x86_64: '4ccf4c80468b6ad4bff81fbec7c4982f3330c4516df751ca866d671fed175a82'
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
