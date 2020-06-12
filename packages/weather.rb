require 'package'

class Weather < Package
  description 'This command-line utility is intended to provide quick access to current weather conditions and forecasts.'
  homepage 'http://fungi.yuggoth.org/weather/'
  version '2.3'
  compatibility 'all'
  source_url 'http://fungi.yuggoth.org/weather/src/weather-2.3.tar.xz'
  source_sha256 '86148d2f1d59867f637f52558cc2a6b3280fac94df55c6e5af0ce37cc190d146'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/weather-2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/weather-2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/weather-2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/weather-2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1b25450f1ee6d3f6ec3b8e0bf356b47741cd7e942b093f6203558dad1a97d5e2',
     armv7l: '1b25450f1ee6d3f6ec3b8e0bf356b47741cd7e942b093f6203558dad1a97d5e2',
       i686: '8d6458b01ac471cde9b77bc5de55ba647896317d98b4d75de8fe6bd0751130cc',
     x86_64: '1c4e0246d00a2fd2511153582862d4b9dccc5a1afb6e7ffd0763a485d60b4490',
  })

  def self.build
    system "echo 'setpath = $HOME/.weather:#{CREW_PREFIX}/data/weather' >> weatherrc"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/data/weather"
    system "mkdir -p #{CREW_DEST_PREFIX}/etc"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man5"
    system "cp weather #{CREW_DEST_PREFIX}/bin"
    system "cp weather.py #{CREW_DEST_PREFIX}/bin"
    system "cp airports #{CREW_DEST_PREFIX}/data/weather"
    system "cp places #{CREW_DEST_PREFIX}/data/weather"
    system "cp slist #{CREW_DEST_PREFIX}/data/weather"
    system "cp stations #{CREW_DEST_PREFIX}/data/weather"
    system "cp zctas #{CREW_DEST_PREFIX}/data/weather"
    system "cp zlist #{CREW_DEST_PREFIX}/data/weather"
    system "cp zones #{CREW_DEST_PREFIX}/data/weather"
    system "cp weatherrc #{CREW_DEST_PREFIX}/etc"
    system "cp weather.1 #{CREW_DEST_PREFIX}/man/man1"
    system "cp weatherrc.5 #{CREW_DEST_PREFIX}/man/man5"
  end

  def self.postinstall
    system "if [ ! -d $HOME/.weather ]; then mkdir $HOME/.weather; fi"
    system "if [ ! -f $HOME/.weather/weatherrc ]; then cp #{CREW_PREFIX}/etc/weatherrc $HOME/.weather; fi"
  end
end
