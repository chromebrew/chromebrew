require 'package'

class Google_webdesigner < Package
  description 'Google Web Designer'
  homepage 'https://webdesigner.withgoogle.com/'
  version '14.0.1.0-1'
  license 'google-webdesigner'
  compatibility 'x86_64'
  source_url 'https://dl.google.com/linux/webdesigner/deb/pool/main/g/google-webdesigner/google-webdesigner_14.0.1.0-1_amd64.deb'
  source_sha256 'c22385674a38b5693f8933fb09c61ae6d8f861cadad96d390d94549787d0ec97'

  depends_on 'nspr'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'expat'
  depends_on 'cras'
  depends_on 'lsb_release'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX.to_s
    FileUtils.mv 'opt/google/webdesigner', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s '../share/webdesigner/webdesigner', "#{CREW_DEST_PREFIX}/bin/webdesigner-stable"
    FileUtils.ln_s '../share/webdesigner/webdesigner', "#{CREW_DEST_PREFIX}/bin/webdesigner"
  end

  def self.postinstall
    ExitMessage.add "\nType 'webdesigner' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.local/share/google-web-designer"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
