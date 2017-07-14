require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u131'
  case ARCH
  when 'i686'
    source_url 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=220303_d54c1d3a095b4ff2b6607d096fa80163'
    source_sha256 'a773f2fe17061ef637ed2094b06313a99c0b45ba3d3cb7f8f1ebf18448495aeb'
  when 'x86_64'
    source_url 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=220305_d54c1d3a095b4ff2b6607d096fa80163'
    source_sha256 '355e5cdb066d4cada1f9f16f358b6fa6280ff5caf7470cf0d5cdd43083408d35'
  when 'armv7l'
    source_url 'https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz'
    source_sha256 'be13670ce0588a888190a55a63a4a95940b8cd77f6dea3dfeaefe3a9ed800c0b'
  when 'aarch64'
    source_url 'https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz'
    source_sha256 'be13670ce0588a888190a55a63a4a95940b8cd77f6dea3dfeaefe3a9ed800c0b'
  end
  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local"
    system "cp -r bin/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r lib/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r man/ #{CREW_DEST_DIR}/usr/local"
  end
end
