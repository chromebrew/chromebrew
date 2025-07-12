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
    aarch64: '086f60a4785b1e8437aaf85386f5c0ece9026c8d99fcd196203816d16e2f1a48',
     armv7l: '086f60a4785b1e8437aaf85386f5c0ece9026c8d99fcd196203816d16e2f1a48',
       i686: '22a2086f617b2ae9c6b321218fd92d15a43945bf46b21b923b26465fcfcadb32',
     x86_64: '9889a16d8173fb7c7d071d1f4148b7e73066cf458c3b3d3660b1f15d3b9b393a'
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
