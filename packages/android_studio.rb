require 'package'

class Android_studio < Package
  description 'Android Studio is the official IDE for Android development.'
  homepage 'https://developer.android.com/studio'
  version '2023.1.1.26'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.1.1.26/android-studio-2023.1.1.26-linux.tar.gz'
  source_sha256 '977e8a9855414f7d41157f0be0e10fb740c42bd337f763d5d96b3e059780663d'

  depends_on 'openjdk17'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.preflight
    free_space = `echo $(($(stat -f --format="%a*%S" #{CREW_PREFIX})))`.chomp.to_i
    abort 'Not enough free disk space.  You need at least 6 GB to install.'.lightred if free_space < 6442450944
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.mv 'bin', "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.mv 'lib', "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.mv 'plugins', "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.cd "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s "#{CREW_PREFIX}/share/android-studio/bin/studio.sh", 'studio'
    end
  end

  def self.postinstall
    puts "\nTo start using Android Studio, type `studio`.\n".lightblue
  end

  def self.remove
    print 'Would you like to remove the config directories? [y/N] '
    response = $stdin.gets.chomp.downcase
    config_dirs = ["#{HOME}/.android", "#{HOME}/Android"]
    config_dirs.each do |config_dir|
      next unless Dir.exist? config_dir

      case response
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
