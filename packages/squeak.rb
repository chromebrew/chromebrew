require 'package'

class Squeak < Package
  description 'Squeak is an open-source Smalltalk programming system with fast execution environments for all major platforms.'
  homepage 'https://squeak.org/'
  version '5.3-19439'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'http://files.squeak.org/5.3/Squeak5.3-19439-64bit/Squeak5.3-19439-64bit-202003021730-Linux.zip'
    source_sha256 'c2e64c9eabf5e94a19766b5fab809b37986c3874767d0fdba4b6139043dfa19a'
  end

  depends_on 'pulseaudio'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/squeak"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/squeak"
    FileUtils.ln_s "#{CREW_PREFIX}/share/squeak/squeak.sh", "#{CREW_DEST_PREFIX}/bin/squeak"
  end
end
