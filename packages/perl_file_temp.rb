require 'buildsystems/perl'

class Perl_file_temp < PERL
  description 'Return name and handle of a temporary file safely'
  homepage 'https://metacpan.org/pod/File::Temp'
  version "0.2311-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/File-Temp-0.2311.tar.gz'
  source_sha256 '2290d61bf5c39882fc3311da9ce1c7f42dbdf825ae169e552c59fe4598b36f4a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '912b9db31ed2470605623fd9594761dbe75796630df848673836ad36894119dd',
     armv7l: '912b9db31ed2470605623fd9594761dbe75796630df848673836ad36894119dd',
       i686: '3db8451e13f1e4fbd0edf6ba9bf97a02debe6e199d19a00ef68c42141cdcbeff',
     x86_64: '15e1e6f89fce08e3fc2a30612c71a9e1cb14fa1fca616d84f03446956da58923'
  })

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @perl_conflicts = %w[
      File::Temp
    ]
    @perl_conflicts.each do |conflict|
      if File.exist?("#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3")
        FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3",
                     "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
      end
    end
  end
end
