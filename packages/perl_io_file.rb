require 'buildsystems/perl'

class Perl_io_file < PERL
  description 'Supply object methods for filehandles'
  homepage 'https://metacpan.org/pod/IO::File'
  version "1.55_01-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/IO-1.55_01.tar.gz'
  source_sha256 '6f51f8dc75c9fa42b1dcd8194575f21f7e0353136a4c9b36e27da1fbeb698074'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ddff773b8af7033bcb92e706045251fed9788f4eff64c3eca8388ec16dd6e66',
     armv7l: '5ddff773b8af7033bcb92e706045251fed9788f4eff64c3eca8388ec16dd6e66',
       i686: 'eb9046dd3a2ba12316af327894e27b6fcd5889f9149436a57faa8c27886bf34f',
     x86_64: 'b651176529ef15ddb49d9e8c2a947959b9be51a2bcdb8b20bc9fdd6e39af05d7'
  })

  depends_on 'perl_file_temp' => :build
  depends_on 'glibc' # R

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @perl_conflicts = %w[
      File::Temp
      IO::Pipe
      IO::Poll
      IO::Seekable
      IO::Select
      IO::Socket
      IO::Socket::INET
      IO::Socket::UNIX
      IO
      IO::Dir
      IO::File
      IO::Handle
    ]
    @perl_conflicts.each do |conflict|
      if File.exist?("#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3")
        FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3",
                     "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
      end
    end
  end
end
