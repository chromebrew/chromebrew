require 'package'

class Spark < Package
  description 'sparklines for your shell'
  homepage 'https://zachholman.com/spark/'
  version 'ab88ac'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/holman/spark/ab88ac6f8f33698f39ece2f109b1117ef39a68eb/README.md'
  source_sha256 '85a153beeafea5637615644f2e92e47e71c621ffa1b0d995acadf51d1c9bbd0d'

  def self.install
    system 'wget https://raw.githubusercontent.com/holman/spark/ab88ac6f8f33698f39ece2f109b1117ef39a68eb/spark'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('spark') ) == '1fa0ef384309239f27f8c98c843639cac2c59e4fe51413cca9836ea64f73329d'
    system "install -Dm755 spark #{CREW_DEST_PREFIX}/bin/spark"
  end
end
