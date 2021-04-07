require 'package'

class Depot_tools < Package
  description 'Chromium uses a package of scripts, the depot_tools, to manage interaction with the Chromium source code repository and the Chromium development process.'
  homepage 'https://dev.chromium.org/developers/how-tos/depottools'
  @_ver = 'da768751'
  version @_ver
  license 'BSD-Google'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xdg_base'

  def self.install
    system "git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git --depth 10"
    Dir.chdir 'depot_tools' do
      system "git checkout #{@_ver}"
      FileUtils.rm_rf 'man/src/'
      FileUtils.rm_rf Dir.glob('.git*')
      system 'find -name \'*.bat\' -delete'
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/depot_tools/"
      FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/"
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/doc/depot_tools/"
      FileUtils.mv Dir.glob('man/html/*.html'), "#{CREW_DEST_PREFIX}/share/doc/depot_tools/"
      FileUtils.mv Dir.glob('man/*'), "#{CREW_DEST_MAN_PREFIX}"
      FileUtils.rm_r 'man/'
      FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/depot_tools"
      FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/.vpython-root"
      FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/.vpython_cipd_cache"
      FileUtils.ln_s "#{HOME}/.config/.vpython-root/", "#{CREW_DEST_HOME}/.vpython-root"
      FileUtils.ln_s "#{HOME}/.config/.vpython_cipd_cache/", "#{CREW_DEST_HOME}/.vpython_cipd_cache"
    end

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @depot_tools_env = <<~DEPOT_TOOLS_EOF
      # Add depot-tools to path
      PATH="$PATH:#{CREW_PREFIX}/share/depot_tools"
    DEPOT_TOOLS_EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/depot_tools", @depot_tools_env)
  end

  def self.remove
    FileUtils.rm_rf Dir.glob("#{HOME}/.config/.vpython*")
  end
end
