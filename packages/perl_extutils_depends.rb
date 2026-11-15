require 'buildsystems/perl'

class Perl_extutils_depends < PERL
  description 'Easily build XS extensions that depend on XS extensions'
  homepage 'https://metacpan.org/pod/ExtUtils::Depends'
  version "0.8002-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/E/ET/ETJ/ExtUtils-Depends-#{version.split('-')[0]}.tar.gz"
  source_sha256 '02b9a46450050ce19b325b23e46bb4ec644229d7f2d95044f67a86d8efacdc29'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1654a8fc09eec433506a1f64df8f6460abcb01f0206116051d6dc2bf2ed0737a',
     armv7l: '1654a8fc09eec433506a1f64df8f6460abcb01f0206116051d6dc2bf2ed0737a',
       i686: 'c1896bece520c55863e5157cbfa1831f85656ac89f8852fbacb23767e225f3b6',
     x86_64: '47749611a7b26f12d7b8cf959ff6e979fc64cefd2bff985945afc6a4a71fa868'
  })

  depends_on 'perl' => :logical
  depends_on 'perl_data_dumper' => :build
  depends_on 'perl_extutils_makemaker' => :build
  depends_on 'perl_file_spec' => :build
  depends_on 'perl_io_file' => :build

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @perl_conflicts = %w[
      Data::Dumper
    ]
    @perl_conflicts.each do |conflict|
      if File.exist?("#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3")
        FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3",
                     "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
      end
    end
  end
end
