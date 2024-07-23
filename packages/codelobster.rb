require 'package'

class Codelobster < Package
  description 'Free cross-platform IDE for PHP/HTML/CSS/JavaScript development'
  homepage 'https://www.codelobster.com/'
  version '1.11.1'
  license 'Shareware'
  compatibility 'x86_64'
  source_url 'https://codelobsteride.com/download/codelobsteride-1.11.1_amd64.deb'
  source_sha256 '7772c87bfda497caaf48ce92ad263a57e537f898fc307a213159d73f9b95e28f'
  binary_compression 'tpxz'

  depends_on 'curl'
  depends_on 'sommelier'

  binary_sha256({
    x86_64: 'bb07382b79b0c7a2a11fb35f2364e21497623362f8ef1a21fac0dbda15a5b6d8'
  })

  def self.preflight
    abort 'Please remove qt5_base before installing.'.lightred if File.exist? "#{CREW_LIB_PREFIX}/libQt5Core.so.5"
    free_space = `echo $(($(stat -f --format="%a*%S" .)))`.chomp.to_i
    abort 'Not enough free disk space.  You need at least 1.2 GB to install.'.lightred if free_space < 1288490188
  end

  def self.patch
    system "sed -i 's,/opt/,#{CREW_PREFIX}/share/,' usr/bin/codelobster"
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv 'usr/bin', CREW_DEST_PREFIX
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/codelobsteride', "#{CREW_DEST_PREFIX}/share"
  end

  def self.postinstall
    puts "\nType 'codelobster' to get started.\n".lightblue
  end
end
