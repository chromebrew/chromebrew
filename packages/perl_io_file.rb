require 'buildsystems/perl'

class Perl_io_file < PERL
  description 'Supply object methods for filehandles'
  homepage 'https://metacpan.org/pod/IO::File'
  version '1.55_01-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/IO-1.55_01.tar.gz'
  source_sha256 '6f51f8dc75c9fa42b1dcd8194575f21f7e0353136a4c9b36e27da1fbeb698074'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: 'f3b5d52e924b4956f59ef3a208ec072776fa15581318d2e3b6dba4e7173f5e35',
    aarch64: '516c7716b17956229bd49f9ab6704f1021a25ae71b4f8769107e5db29550ccb2',
     armv7l: '516c7716b17956229bd49f9ab6704f1021a25ae71b4f8769107e5db29550ccb2',
     x86_64: 'df3365990bf5fcdd29e3c8b664cc04b188d66d9e6fea4693c3bd48ba4afa1a7c'
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
