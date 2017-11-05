require 'package'

class Mp4v2 < Package
  description 'MP4v2 Library: This library provides functions to read, create, and modify mp4 files'
  homepage 'https://code.google.com/archive/p/mp4v2/'
  version '2.0.0'
  source_url 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mp4v2/mp4v2-2.0.0.tar.bz2'
  source_sha256 '0319b9a60b667cf10ee0ec7505eb7bdc0a2e21ca7a93db96ec5bd758e3428338'

  def self.preinstall
    system "curl -Ls -o autoaux/config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'"
    system "curl -Ls -o autoaux/config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'"
  end

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-dependency-tracking \
            --disable-debug"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
