require 'package'

class Lolcat < Package
  description 'Rainbows and unicorns!'
  homepage 'https://github.com/busyloop/lolcat'
  version '99.9.19'
  source_url 'https://github.com/busyloop/lolcat/archive/v99.9.19.tar.gz'
  source_sha256 '2ec5beb8051576600adf3197b9826ce3319a18448bd0dbb8a92a028be8370449'

  def self.install
    system "gem install lolcat"
  end

  def self.postinstall
    system "echo spam blah blah blah>>/tmp/lol"
    system "echo this is randomness>>/tmp/lol"
    system "echo uwuwuwuwuwuwuwuwuwu>>/tmp/lol"
    system "echo rainbows and unicorns!>>/tmp/lol"
    system "echo cotton candy lol!!!1!>>/tmp/lol"
    system "echo yay kittens =^~^=>>/tmp/lol"
    system "lolcat /tmp/lol --freq=0.5"
    system "rm /tmp/lol"
  end
end
