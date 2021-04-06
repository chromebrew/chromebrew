require 'package'

class Vivaldi < Package
  description 'Vivaldi is a new browser that blocks unwanted ads, protects you from trackers, and puts you in control with unique built-in features.'
  homepage 'https://vivaldi.com/'
  @_ver = '3.7.2218.52'
  version @_ver
  compatibility 'all'
  license 'Vivaldi'

  depends_on 'cras'
  depends_on 'gtk3'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libx264'
  depends_on 'xdg_base'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

  case ARCH
  when 'aarch64', 'armv7l'
    @_arch = 'armhf'
    source_sha256 '1f92f3ea5ef6d2260b2784089d334a32be54aa3d955955fc3cc443d8937cae06'
  when 'x86_64'
    @_arch = 'amd64'
    source_sha256 'f131f182bc6dd6e735a83ffaa4ff2a3cca90184daa26e0996d1cb64ed765ab2a'
  when 'i686'
    @_arch = 'i386'
    source_sha256 '6f93e285e1cd48103fbdc3266e1188556ed2a98b08f7c6420eeb07c05c559a08'
  end
  
  source_url "https://downloads.vivaldi.com/stable/vivaldi-stable_#{@_ver}-1_#{@_arch}.deb"
  
  def self.patch
    # ERROR: ld.so: object '/home/chronos/user/.local/lib/vivaldi/media-codecs-89.0.4389.82/libffmpeg.so' from LD_PRELOAD cannot be preloaded
    system 'sed', '-i', "s:$HOME/.local/lib/vivaldi/media-codecs-$CODECS_VERSION/libffmpeg.so:#{CREW_PREFIX}/share/vivaldi/lib/libffmpeg.so:g", './opt/vivaldi/vivaldi'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX

    FileUtils.mv './etc/', CREW_DEST_PREFIX
    FileUtils.mv Dir['./usr/*'], CREW_DEST_PREFIX
    FileUtils.mv './opt/vivaldi/', "#{CREW_DEST_PREFIX}/share/"
    
    FileUtils.ln_sf "#{CREW_PREFIX}/share/vivaldi/vivaldi", "#{CREW_DEST_PREFIX}/bin/vivaldi-stable"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/vivaldi/vivaldi", "#{CREW_DEST_PREFIX}/bin/vivaldi"
  end
  
  def self.remove
    FileUtils.rm_rf HOME + '/.local/lib/vivaldi'
    Dir.chdir(CREW_PREFIX) do
      FileUtils.rm_rf ['.config/vivaldi', '.cache/vivaldi', '.config/share/.vivaldi_reporting_data']
    end
  end
end
