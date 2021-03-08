require 'package'

class Android_studio < Package
  description 'Android Studio is the official IDE for Android development.'
  homepage 'https://developer.android.com/studio'
  version '4.1.2.0'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://dl.google.com/dl/android/studio/ide-zips/4.1.2.0/android-studio-ide-201.7042882-linux.tar.gz'
    source_sha256 '89f7c3a03ed928edeb7bbb1971284bcb72891a77b4f363557a7ad4ed37652bb9'
    depends_on 'jdk8'
    depends_on 'xdg_base'
    depends_on 'sommelier'
  end

  def self.preflight
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
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/.config/.AndroidStudio4.1')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/.config/Android')
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.cd(CREW_DEST_HOME) do
      FileUtils.ln_sf(CREW_PREFIX + '/.config/.AndroidStudio4.1/', '.AndroidStudio4.1')
      FileUtils.ln_sf(CREW_PREFIX + '/.config/Android/', 'Android')
    end
  end

  def self.postinstall
    puts
    puts 'To start using Android Studio, type `studio`.'.lightblue
    puts
  end

  def self.remove
    FileUtils.rm_rf "#{CREW_PREFIX}/.config/Android"
    FileUtils.rm_rf "#{CREW_PREFIX}/.config/.AndroidStudio4.1"
  end
end
