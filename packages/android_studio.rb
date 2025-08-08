require 'package'
require 'misc_functions'

class Android_studio < Package
  description 'Android Studio is the official IDE for Android development.'
  homepage 'https://developer.android.com/studio'
  version '2025.1.2.11'
  license 'Apache-2.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/#{version}/android-studio-#{version}-linux.tar.gz"
  source_sha256 '8f3874c6b119538cdd96c7bcb65555feea81133e251f69365d21ddd77777be78'

  depends_on 'openjdk17'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  print_source_bashrc

  @short_ver = version.sub(/\.\d+$/, '')

  def self.preflight
    # Need at least 7.5 gb of free disk space to install.
    MiscFunctions.check_free_disk_space(8053063680)
  end

  def self.patch
    # product-info.json must exist in the installation directory.
    system "sed -i '7i[ ! -f \$(pwd)/product-info.json ] && touch product-info.json' bin/studio.sh"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.mv 'bin', "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.mv 'lib', "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.mv 'plugins', "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.ln_s "#{CREW_PREFIX}/share/android-studio/bin/studio.sh", "#{CREW_DEST_PREFIX}/bin/studio"
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/.cache/Google/AndroidStudio#{@short_ver}/tmp"
    ExitMessage.add "\nType `studio` to start using Android Studio.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.cache/Google/AndroidStudio#{@short_ver}")
    Package.agree_to_remove("#{HOME}/.android")
    Package.agree_to_remove("#{HOME}/Android")
    Package.agree_to_remove("#{HOME}/StudioProjects")
  end
end
