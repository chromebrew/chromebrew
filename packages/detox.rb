require 'package'

class Detox < Package
  description 'Detox is a utility designed to clean up filenames. It replaces non-standard characters, such as spaces, with standard equivalents.'
  homepage 'https://sourceforge.net/projects/detox/'
  version '1.2.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/detox/detox/1.2.0/detox-1.2.0.tar.bz2'
  source_sha256 'abfad90ee7d3e0fc53ce3b9da3253f9a800cdd92e3f8cc12a19394a7b1dcdbf8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/detox-1.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/detox-1.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/detox-1.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/detox-1.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3afa40ee3b414e1d049c0d430c384637361fd41f3fdb4c7af8113a5f958dd94d',
     armv7l: '3afa40ee3b414e1d049c0d430c384637361fd41f3fdb4c7af8113a5f958dd94d',
       i686: '51cf04893445a8309f2f0f7eab60920d28a901ed9327ae6631d3d802b70e355f',
     x86_64: '59ac0cd7bea3765b24f7e76837c48cccd429cf67cfcfcc7220ca662dc858631e',
  })

  depends_on 'flex'
  depends_on 'popt'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--with-popt=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
