require 'package'

class Halibut < Package
  description 'Halibut is a documentation production system, with elements similar to TeX, debiandoc-sgml, TeXinfo, and others.'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/halibut/'
  version '1.2'
  compatibility 'all'
  source_url 'https://www.chiark.greenend.org.uk/~sgtatham/halibut/halibut-1.2/halibut-1.2.tar.gz'
  source_sha256 '1aedfb6240f27190c36a390fcac9ce732edbdbaa31c85ee675b994e2b083163f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/halibut-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/halibut-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/halibut-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/halibut-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '04f12bb5ff68ea5c4c279f98591f8b98e07ec60286dff0bcadf5c20a5a42e257',
     armv7l: '04f12bb5ff68ea5c4c279f98591f8b98e07ec60286dff0bcadf5c20a5a42e257',
       i686: '8281a31fe9ebfe71053d6a219064714470fe1e8261ab6483a85e731604e64d1b',
     x86_64: '93bd79b97de9b7be01ccbe82ab3272ad9be6ead4e26376ac2ce4529e5b50a9dc',
  })

  def self.build
    system 'make'
    FileUtils.cd('doc') do
      system 'make'
    end
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "cp build/halibut #{CREW_DEST_PREFIX}/bin"
    system "cp doc/halibut.1 #{CREW_DEST_PREFIX}/man/man1"
  end
end
