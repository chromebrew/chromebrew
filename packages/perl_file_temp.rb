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
    aarch64: '',
     armv7l: '',
       i686: '2f3529cad14b3d7cad87c86bb6f9f0c82aa02fc0bfcad46e759c194765bf939d',
     x86_64: 'e8cef1dc9ce781afa80cac42f5e8214162ac27296993d2cb0578b55c08c41638'
  })

  binary_sha256({
    aarch64: 'f9b6175f87a1189d26427470ef95814af14b4b0f0ee4a9037d0b819e661a8998',
     armv7l: 'f9b6175f87a1189d26427470ef95814af14b4b0f0ee4a9037d0b819e661a8998',
       i686: 'b04f9380e50a3b35e42d2d92b90ec1b88205f8934f6ec23d8921ab6594f6f7b7',
     x86_64: 'e8cef1dc9ce781afa80cac42f5e8214162ac27296993d2cb0578b55c08c41638'
  })

  depends_on 'perl' => :logical

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
