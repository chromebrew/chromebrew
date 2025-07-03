require 'package'
require 'convenience_functions'

class Vivaldi < Package
  description 'Vivaldi is a new browser that blocks unwanted ads, protects you from trackers, and puts you in control with unique built-in features.'
  homepage 'https://vivaldi.com/'
  version '7.5.3735.41-1'
  license 'Vivaldi'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.37'

  depends_on 'cras'
  depends_on 'gtk3'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libx264'
  depends_on 'nss'
  depends_on 'xdg_base'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  case ARCH
  when 'aarch64', 'armv7l'
    arch = 'armhf'
    source_sha256 'bd851dd2069e54c1bfba7fd046944bb2bca1676f4988302093e83e52fe391210'
  when 'x86_64'
    arch = 'amd64'
    source_sha256 '7f7bc20b5f0cc192c4a9730cebded790cbc0908d07e2af096e317dc6bab1368f'
  end

  source_url "https://downloads.vivaldi.com/stable/vivaldi-stable_#{version}_#{arch}.deb"

  def self.patch
    # ERROR: ld.so: object '/home/chronos/user/.local/lib/vivaldi/media-codecs-89.0.4389.82/libffmpeg.so' from LD_PRELOAD cannot be preloaded
    system 'sed', '-i', "s:$HOME/.local/lib/vivaldi/:#{CREW_PREFIX}/share/vivaldi/:g", './opt/vivaldi/vivaldi'
    system 'sed', '-i', "s:$HOME/.local/lib/vivaldi/:#{CREW_PREFIX}/share/vivaldi/:g", './opt/vivaldi/update-ffmpeg'
    system 'sed', '-i', 's:/usr/bin/::g', './usr/share/applications/vivaldi-stable.desktop'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX

    FileUtils.mv './etc/', CREW_DEST_PREFIX
    FileUtils.mv Dir['./usr/*'], CREW_DEST_PREFIX
    FileUtils.mv './opt/vivaldi/', "#{CREW_DEST_PREFIX}/share/"

    FileUtils.ln_sf "#{CREW_PREFIX}/share/vivaldi/vivaldi", "#{CREW_DEST_PREFIX}/bin/vivaldi-stable"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/vivaldi/vivaldi", "#{CREW_DEST_PREFIX}/bin/vivaldi"

    # Add icons for use with crew-launcher
    icon_base_path = "#{CREW_DEST_PREFIX}/share/icons/hicolor"
    FileUtils.mkdir_p icon_base_path
    Dir["#{CREW_DEST_PREFIX}/share/vivaldi/product_logo_*.png"].each do |filename|
      logo = File.basename(filename)
      size = File.basename(logo[13, 7], '.png')
      dims = "#{size}x#{size}"
      FileUtils.mkdir_p "#{icon_base_path}/#{dims}/apps"
      FileUtils.mv filename, "#{icon_base_path}/#{dims}/apps/vivaldi.png"
    end
  end

  def self.postinstall
    system "#{CREW_PREFIX}/share/vivaldi/update-ffmpeg", '--user'
    ConvenienceFunctions.set_default_browser('Vivaldi', 'vivaldi')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('Vivaldi', 'vivaldi')
  end

  def self.postremove
    Dir.chdir(CREW_PREFIX) do
      FileUtils.rm_rf ["#{HOME}/.local/lib/vivaldi", '.config/vivaldi', '.cache/vivaldi', '.config/share/.vivaldi_reporting_data']
    end
  end
end
