require 'package'

class Mp4v2 < Package
  description 'MP4v2 Library: This library provides functions to read, create, and modify mp4 files'
  homepage 'https://code.google.com/archive/p/mp4v2/'
  version '2.0.0'
  compatibility 'all'
  source_url 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mp4v2/mp4v2-2.0.0.tar.bz2'
  source_sha256 '0319b9a60b667cf10ee0ec7505eb7bdc0a2e21ca7a93db96ec5bd758e3428338'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mp4v2-2.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mp4v2-2.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mp4v2-2.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mp4v2-2.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a636db38c7bc1f2ea3d01f64d271f56edd37ffeafdbb792701a352ce996bcc2e',
     armv7l: 'a636db38c7bc1f2ea3d01f64d271f56edd37ffeafdbb792701a352ce996bcc2e',
       i686: '364b76b514b0f942336f821fc2c8216d1b5cb540b820fcf0233eda451ec578ce',
     x86_64: '0c65a40cbef64c0d33c3d2e7d2b46ea83d0a14f053de873f0efa62dc79f8841b',
  })

  def self.patch
    system "curl -Ls -o autoaux/config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'"
    system "curl -Ls -o autoaux/config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-dependency-tracking --disable-debug"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
