require 'package'

class Weather < Package
  description 'This command-line utility is intended to provide quick access to current weather conditions and forecasts.'
  homepage 'https://fungi.yuggoth.org/weather/'
  version '2.5.0'
  license 'ISC'
  compatibility 'all'
  source_url "https://fungi.yuggoth.org/weather/src/weather-#{version}.tar.xz"
  source_sha256 'c27ddca607eb96a9ed308895161e37d7b0eb6c6810e18467173dca1d769c4f0e'

  no_compile_needed
  print_source_bashrc

  def self.build
    File.write 'weatherrc', <<~EOF
      [default]
      setpath = .:#{HOME}/.weather:#{CREW_PREFIX}/share/weather/data
    EOF
  end

  def self.install
    FileUtils.install %w[weather weather.py], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install %w[airports places slist stations zctas zlist zones], "#{CREW_DEST_PREFIX}/share/weather/data", mode: 0o644
    FileUtils.install 'weatherrc', "#{CREW_DEST_HOME}/.weather/weatherrc", mode: 0o600
    FileUtils.install 'weather.1', "#{CREW_DEST_MAN_PREFIX}/man1/weather.1", mode: 0o644
    FileUtils.install 'weatherrc.5', "#{CREW_DEST_MAN_PREFIX}/man5/weatherrc.5", mode: 0o644
  end
end
