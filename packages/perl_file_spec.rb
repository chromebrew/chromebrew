require 'buildsystems/perl'

class Perl_file_spec < PERL
  description 'Portably perform operations on file names'
  homepage 'https://metacpan.org/pod/File::Spec'
  version '3.75-perl5.38.2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XS/XSAWYERX/PathTools-3.75.tar.gz'
  source_sha256 'a558503aa6b1f8c727c0073339081a77888606aa701ada1ad62dd9d8c3f945a2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38.2_armv7l/perl_file_spec-3.75-perl5.38.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38.2_armv7l/perl_file_spec-3.75-perl5.38.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38.2_i686/perl_file_spec-3.75-perl5.38.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38.2_x86_64/perl_file_spec-3.75-perl5.38.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2ed934fd7718877eab532dc0281db9e1ba496b99754d79d4f48591db27130033',
     armv7l: '2ed934fd7718877eab532dc0281db9e1ba496b99754d79d4f48591db27130033',
       i686: '4a6339226d7592d156e77549a2ee7efa06c5867e4633352b80410e9aad5f6746',
     x86_64: '452caefac51321458273387f6cc4149d544827e5c21c115a81420ac76ac0ab5c'
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
