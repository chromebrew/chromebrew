require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u181'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u181-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u181-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u181-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u181-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '79d39e708a48b1b38369df5c7b9dbc370150b516992c264e87ce84bc9645da0e',
     armv7l: '79d39e708a48b1b38369df5c7b9dbc370150b516992c264e87ce84bc9645da0e',
       i686: '5eac08d3901b5bca84cdb897b74d5433fe196b5824654da271052f3360c7492a',
     x86_64: 'aeae8471e898fa7b90664eb96a2874c6906ca4f04bbe914aa3d756922b265634',
  })

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-arm32-vfp-hflt.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u181-linux-arm32-vfp-hflt.tar.gz') ) == 'c72e37da3c34531949b74a5bd846a3862933408df6306358fcea27876158ef7e'
      system 'tar xvf jdk-8u181-linux-arm32-vfp-hflt.tar.gz'
    when 'i686'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-i586.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u181-linux-i586.tar.gz') ) == 'd78a023abffb7ce4aade43e6db64bbad5984e7c82c54c332da445c9a79c1a904'
      system 'tar xvf jdk-8u181-linux-i586.tar.gz'
    when 'x86_64'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u181-linux-x64.tar.gz') ) == '1845567095bfbfebd42ed0d09397939796d05456290fb20a83c476ba09f991d3'
      system 'tar xvf jdk-8u181-linux-x64.tar.gz'
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd('jdk1.8.0_181') do
      system "rm -f src.zip"
      system "cp -r * #{CREW_DEST_PREFIX}/share/jdk8"
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "ln -s ../../../#{CREW_PREFIX}/share/jdk8/bin/* ."
    end
    FileUtils.cd("#{CREW_DEST_PREFIX}/share") do
      system "cp -r jdk8/man/ ."
      system "rm -rf jdk8/man/"
    end
  end
end
