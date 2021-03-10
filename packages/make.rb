require 'package'

class Make < Package
  description 'GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program\'s source files.'
  homepage 'https://www.gnu.org/software/make/'
  version '4.3-1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/make/make-4.3.tar.lz'
  source_sha256 'de1a441c4edf952521db30bfca80baae86a0ff1acd0a00402999344f04c45e82'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--enable-cross-guesses=conservative'
    system './build.sh'
  end

  def self.install
    system './make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.symlink 'make', 'gmake'
    end
  end

  def self.check
    # Give it several tries since output-sync fails rarely
    system './make check || ./make check || ./make check'
  end
end
