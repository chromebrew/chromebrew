require 'package'

class Parsec < Package
  description 'Parsec is a remote desktop application made specifically for cloud gaming.'
  homepage 'https://parsecgaming.com'
  version '150_28'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
    
    depends_on 'alien' => :build
    depends_on 'freetype'
    depends_on 'libsm'
    depends_on 'gdk_pixbuf'
    depends_on 'gtk2'
    depends_on 'sommelier'

  def self.build
    case ARCH
    when 'aarch64', 'armv7l'
    	system 'curl https://builds.parsecgaming.com/package/parsec-linux.deb -#o parsec.deb'
 	puts "Archive downloaded".lightgreen
   	abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('parsec.deb') ) == 'a98e840dc44f4762018895bd0da704c88887815de0e74e0f39aa7737f5b0e802'
    when 'x86_64', 'i686'
        system 'curl https://builds.parsecgaming.com/package/parsec-rpi.deb -#o parsec.deb'
    	puts "Archive downloaded".lightgreen
    	abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('parsec.deb') ) == '0c7207f419377fc35e30448acd00d8701300ac5a44936ac6d87a468c9afccdc1'
    end
    system 'alien -tc parsec.deb'
    system "tar xvf parsec*.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
