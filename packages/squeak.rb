require 'package'

class Squeak < Package
  description 'Squeak is an open-source Smalltalk programming system with fast execution environments for all major platforms.'
  homepage 'https://squeak.org/'
  version '5.3-19459'
  license 'MIT and Apache-2.0'
  compatibility 'x86_64'
  source_url 'http://files.squeak.org/5.3/Squeak5.3-19459-64bit/Squeak5.3-19459-64bit-202003021730-Linux.zip'
  source_sha256 'f154c3e87c218fae7451598e2106f60bae67830a45681a093cc376ba68a9941d'

  depends_on 'pulseaudio'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/libexec/squeak"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/libexec/squeak"
    FileUtils.ln_s "#{CREW_PREFIX}/libexec/squeak/squeak.sh", "#{CREW_DEST_PREFIX}/bin/squeak"
  end
end
