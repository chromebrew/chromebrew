require 'package'

class Halibut < Package
  description 'Halibut is a documentation production system, with elements similar to TeX, debiandoc-sgml, TeXinfo, and others.'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/halibut/'
  version '1.2'
  source_url 'https://www.chiark.greenend.org.uk/~sgtatham/halibut/halibut-1.2/halibut-1.2.tar.gz'
  source_sha256 '1aedfb6240f27190c36a390fcac9ce732edbdbaa31c85ee675b994e2b083163f'

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
