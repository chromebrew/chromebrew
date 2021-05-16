require 'package'

class Android_studio < Package
  description 'Android Studio is the official IDE for Android development.'
  homepage 'https://developer.android.com/studio'
  version '4.2.1.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://redirector.gvt1.com/edgedl/android/studio/install/4.2.1.0/android-studio-ide-202.7351085-cros.deb'
  source_sha256 '6263ed1c69c358dd4708c0ee8b65144c2b7681e79f4ec2a4954144020664f5c3'

  depends_on 'jdk8'
  depends_on 'sommelier'

  def self.preflight
    free_space = `echo $(($(stat -f --format="%a*%S" .)))`.chomp.to_i
    abort 'Not enough free disk space.  You need at least 6 GB to install.'.lightred if free_space < 6442450944
  end

  def self.install
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/bin')
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/android-studio', CREW_DEST_PREFIX + '/share'
    FileUtils.cd(CREW_DEST_PREFIX + '/bin') do
      FileUtils.ln_s(CREW_PREFIX + '/share/android-studio/bin/studio.sh', 'studio')
    end
  end

  def self.postinstall
    puts "\nTo start using Android Studio, type `studio`.\n".lightblue
  end

  def self.remove
    print "Would you like to remove the config directories? [y/N] "
    response = STDIN.getc
    config_dirs = ["#{HOME}/.android", "#{HOME}/Android"]
    config_dirs.each { |config_dir|
      if Dir.exists? config_dir
        case response
        when "y", "Y"
          FileUtils.rm_rf config_dir
          puts "#{config_dir} removed.".lightred
        else
          puts "#{config_dir} saved.".lightgreen
        end
      end
    }
  end
end
