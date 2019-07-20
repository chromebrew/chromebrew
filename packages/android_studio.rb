require 'package'

class Android_studio < Package
  description 'Android Studio is the official IDE for Android development.'
  homepage 'https://developer.android.com/studio'
  version '3.4.1.0'
  source_url 'https://dl.google.com/dl/android/studio/ide-zips/3.4.1.0/android-studio-ide-183.5522156-linux.tar.gz'
  source_sha256 '60488b63302fef657367105d433321de248f1fb692d06dba6661efec434b9478'

  depends_on 'jdk8'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  if ARGV[0] == 'install' || ARGV[0] == 'upgrade' then
    free_space = `echo $(($(stat -f --format="%a*%S" .)))`.chomp.to_i
    abort 'Not enough free disk space.  You need at least 6 GB to install.'.lightred if free_space < 6442450944
  end

  def self.install
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/share/android-studio')
    FileUtils.cp_r('.', CREW_DEST_PREFIX + '/share/android-studio/')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/bin')
    FileUtils.cd(CREW_DEST_PREFIX + '/bin') do
      FileUtils.ln_s(CREW_PREFIX + '/share/android-studio/bin/studio.sh', 'studio')
    end
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/.config/.AndroidStudio3.4')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/.config/Android')
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.cd(CREW_DEST_HOME) do
      FileUtils.ln_sf(CREW_PREFIX + '/.config/.AndroidStudio3.4/', '.AndroidStudio3.4')
      FileUtils.ln_sf(CREW_PREFIX + '/.config/Android/', 'Android')
    end
  end

  def self.postinstall
    puts
    puts 'To start using Android Studio, type `studio`.'.lightblue
    puts
    puts 'To completely remove Android Studio, including the'.lightblue
    puts 'settings, SDK and tools, execute the following:'.lightblue
    puts 'crew remove android_studio'.lightblue
    puts "rm -rf #{CREW_PREFIX}/.config/Android".lightblue
    puts "rm -rf #{CREW_PREFIX}/.config/.AndroidStudio3.3".lightblue
    puts
  end
end
