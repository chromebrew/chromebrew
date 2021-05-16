require 'package'

class Vivaldi < Package
  description 'Vivaldi is a new browser that blocks unwanted ads, protects you from trackers, and puts you in control with unique built-in features.'
  homepage 'https://vivaldi.com/'
  @_ver = '3.8.2259.42'
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
    source_sha256 '7a24258f6cb0578d5200b762ee7c52aed47d979d41923384419b06281a688fdf'
  when 'x86_64'
    @_arch = 'amd64'
    source_sha256 'cd6648b4a6b45069e7bc4955cc0464abca6bd9c5c70f7a63f3a162e9e002f80c'
  when 'i686'
    @_arch = 'i386'
    source_sha256 '68557d8723c3db7acea990524b4c3da895a2a1c150e547fc3bcb2c1590511675'
  end

  source_url "https://downloads.vivaldi.com/stable/vivaldi-stable_#{@_ver}-1_#{@_arch}.deb"

  def self.patch
    # ERROR: ld.so: object '/home/chronos/user/.local/lib/vivaldi/media-codecs-89.0.4389.82/libffmpeg.so' from LD_PRELOAD cannot be preloaded
    system 'sed', '-i', "s:$HOME/.local/lib/vivaldi/:#{CREW_PREFIX}/share/vivaldi/:g", './opt/vivaldi/vivaldi'
    system 'sed', '-i', "s:$HOME/.local/lib/vivaldi/:#{CREW_PREFIX}/share/vivaldi/:g", './opt/vivaldi/update-ffmpeg'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX

    FileUtils.mv './etc/', CREW_DEST_PREFIX
    FileUtils.mv Dir['./usr/*'], CREW_DEST_PREFIX
    FileUtils.mv './opt/vivaldi/', "#{CREW_DEST_PREFIX}/share/"

    FileUtils.ln_sf "#{CREW_PREFIX}/share/vivaldi/vivaldi", "#{CREW_DEST_PREFIX}/bin/vivaldi-stable"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/vivaldi/vivaldi", "#{CREW_DEST_PREFIX}/bin/vivaldi"
  end

  def self.postinstall
    system "#{CREW_PREFIX}/share/vivaldi/update-ffmpeg", '--user'
  end

  def self.remove
    Dir.chdir(CREW_PREFIX) do
      FileUtils.rm_rf ["#{HOME}/.local/lib/vivaldi", '.config/vivaldi', '.cache/vivaldi', '.config/share/.vivaldi_reporting_data']
    end
  end
end
