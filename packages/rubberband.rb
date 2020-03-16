require 'package'

class Rubberband < Package
  description 'Rubber Band Library is a high quality software library for audio time-stretching and pitch-shifting.'
  homepage 'https://breakfastquay.com/rubberband/'
  version '1.8.2'
  source_url 'https://breakfastquay.com/files/releases/rubberband-1.8.2.tar.bz2'
  source_sha256 '86bed06b7115b64441d32ae53634fcc0539a50b9b648ef87443f936782f6c3ca'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rubberband-1.8.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rubberband-1.8.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rubberband-1.8.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rubberband-1.8.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b684aa86b3ef03b2be91f518c5b88d536d9d3152eeab5670fd7117186742be8b',
     armv7l: 'b684aa86b3ef03b2be91f518c5b88d536d9d3152eeab5670fd7117186742be8b',
       i686: 'deb5b36f7b7b2da1390baf2330b533ab82598a46eeb7073d9f334cb905d006f8',
     x86_64: '909761fb62e174eaf6b788afc0c1390a38083d7ac7571260f1e294b560dffdbf',
  })

  depends_on 'ladspa'
  depends_on 'libsamplerate'
  depends_on 'vamp_sdk'

  def self.build
    ENV['JAVA_HOME'] = "#{CREW_PREFIX}/share/jdk8"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    # Remove missing librubberband-jni.so.
    system "sed -i '186d' Makefile"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    if ARCH == 'x86_64'
      Dir.chdir "#{CREW_DEST_PREFIX}" do
        FileUtils.mv 'lib/', 'lib64/'
      end
    end
  end
end
