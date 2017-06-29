require 'package'

class Dtrx < Package
  description "Intelligent archive extraction. dtrx stands for 'Do The Right Extraction.' It's a tool for Unix-like systems that takes all the hassle out of extracting archives."
  homepage 'https://brettcsmith.org/2007/dtrx/'
  version '7.1'
  source_url 'https://brettcsmith.org/2007/dtrx/dtrx-7.1.tar.gz'
  source_sha256 '1c9afe48e9d9d4a1caa4c9b0c50593c6fe427942716ce717d81bae7f8425ce97'

  depends_on 'binutils'
  depends_on 'bz2'
  depends_on 'cabextract'
  depends_on 'cpio'
  depends_on 'lha'
  depends_on 'python27'
  depends_on 'unrar'
  depends_on 'unshield'
  depends_on 'unzip'

  def self.install
    system "python setup.py install --prefix=/usr/local"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp /usr/local/bin/dtrx #{CREW_DEST_DIR}/usr/local/bin"
  end
end
