require 'package'

class Foxit_reader < Package
  description "Industry's most powerful PDF reader. View, annotate, form fill, and sign PDFs."
  homepage 'https://www.foxit.com/pdf-reader/'
  version '2.4.5.0727'
  major = version.split('.')[0]
  minor = version.split('.').slice(0..1).join('.')
  license 'Foxit'
  compatibility 'x86_64'
  source_url "https://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/#{major}.x/#{minor}/en_us/FoxitReader.enu.setup.#{version}.x64.run.tar.gz"
  source_sha256 '633279b6c9fcfa3c45e055df321a87d633ecfea11f668a06e838bb91b5bf6247'

  no_compile_needed

  depends_on 'sommelier'

  def self.install
    # Define directories.
    bin_path = "#{CREW_DEST_PREFIX}/bin"
    root_path = "#{CREW_PREFIX}/share/foxitreader"
    dest_path = "#{CREW_DEST_PREFIX}/share/foxitreader"
    app_path = "#{CREW_DEST_PREFIX}/share/applications"
    icon_path = "#{CREW_DEST_PREFIX}/share/icons/hicolor/64x64/apps"

    puts "IMPORTANT: Copy #{dest_path} to your clipboard and, when prompted, paste to replace".orange
    print "the installation folder. Click 'Ignore' if you experience an error during the installation process. Continue? [y/N] ".orange
    case $stdin.gets.chomp.downcase
    when 'y', 'yes'
      # Launch the installation script.
      system ".'/FoxitReader.enu.setup.#{version}(rb70e8df).x64.run'"
    end
    abort 'Aborted since installation folder not found.'.lightred unless Dir.exist?(dest_path.to_s)

    # Create directories.
    FileUtils.mkdir_p bin_path.to_s
    FileUtils.mkdir_p app_path.to_s
    FileUtils.mkdir_p icon_path.to_s

    # Add symlinks.
    FileUtils.ln_s "#{root_path}/FoxitReader", "#{bin_path}/foxit"
    FileUtils.ln_s "#{root_path}/FoxitReader", "#{bin_path}/foxitreader"
    FileUtils.ln_s "#{root_path}/FoxitReader", "#{bin_path}/FoxitReader"

    # Prepare FoxitReader.desktop and FoxitReader.ico for use with crew-launcher.
    FileUtils.rm "#{dest_path}/Activation.desktop"
    FileUtils.rm "#{dest_path}/Uninstall.desktop"
    FileUtils.rm "#{dest_path}/Update.desktop"
    system "sed -i 's,#{dest_path}/FoxitReader.sh,#{root_path}/FoxitReader,' #{dest_path}/FoxitReader.desktop"
    FileUtils.mv "#{dest_path}/FoxitReader.desktop", app_path.to_s
    FileUtils.mv "#{dest_path}/images/FoxitReader-64x64.ico", "#{icon_path}/FoxitReader.ico"
  end

  def self.postinstall
    ExitMessage.add "\nType 'foxit' to get started.\n"
  end
end
